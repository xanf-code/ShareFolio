import 'package:flutter/material.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';

class UpdateEducation extends StatefulWidget {
  const UpdateEducation({Key key}) : super(key: key);
  @override
  _UpdateEducationState createState() => _UpdateEducationState();
}

class _UpdateEducationState extends State<UpdateEducation> {
  @override
  final TextEditingController _nameUpdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FieldWidget(
            label: "Name",
            hint: "Name",
            controller: _nameUpdate,
            length: 1,
            isObscure: false,
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Tap Here"),
          ),
        ],
      ),
    );
  }
}
