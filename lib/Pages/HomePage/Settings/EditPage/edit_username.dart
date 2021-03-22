import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditUserName extends StatefulWidget {
  final String userName;

  const EditUserName({Key key, this.userName}) : super(key: key);
  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  final TextEditingController _editName = TextEditingController();
  final AuthService _authService = AuthService();
  @override
  void initState() {
    _editName.text = widget.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 32.0,
                top: 14,
                bottom: 18,
              ),
              child: Level1Form(
                type: "Display Name",
              ),
            ),
            FieldWidget(
              label: "Username",
              hint: " ",
              controller: _editName,
              isObscure: false,
            ),
            TextButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                if (_editName.text.isEmpty || _editName.text == " ") {
                  showTopSnackBar(
                    context,
                    const CustomSnackBar.error(
                      message: "Field cannot be empty!",
                    ),
                  );
                } else if (_editName.text.length >= 30) {
                  showTopSnackBar(
                    context,
                    const CustomSnackBar.error(
                      message: "Name too long!",
                    ),
                  );
                } else {
                  Provider.of<FirebaseFunctions>(context, listen: false)
                      .updateUserName(
                    _authService.getCurrentUserUID(),
                    _editName.text,
                    context,
                  );
                }
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
