import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Services/GeneralFunctions/functions.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: camel_case_types
class profileLevel2 extends StatefulWidget {
  final String uid;
  final String status;
  const profileLevel2({Key key, this.uid, this.status}) : super(key: key);
  @override
  _profileLevel2State createState() => _profileLevel2State();
}

// ignore: camel_case_types
class _profileLevel2State extends State<profileLevel2> {
  TextEditingController statusController = TextEditingController();
  @override
  void initState() {
    setState(() {
      statusController.text = widget.status;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        //left: 20.0,
        top: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 12,
            ),
            child: HeadWidget(
              label: "Status",
            ),
          ),
          Stack(
            alignment: const Alignment(1.0, 1.0),
            children: [
              Container(
                color: Color(0xFF1a2b3f),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextField(
                    controller: statusController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tell us about yourself?",
                      hintStyle: GoogleFonts.dmSans(
                        color: Colors.white30,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible:
                    Providers.of(context).auth.getCurrentUserUID() == widget.uid
                        ? true
                        : false,
                child: TextButton(
                  onPressed: () {
                    submitFunction();
                  },
                  child: new Icon(
                    FontAwesomeIcons.checkCircle,
                    color: Colors.white60,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void submitFunction() {
    HapticFeedback.mediumImpact();
    Functions().updateStatus(widget.uid, statusController.text).whenComplete(
      () {
        FocusScope.of(context).unfocus();
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Status Updated",
          ),
        );
      },
    );
  }
}

class HeadWidget extends StatelessWidget {
  final String label;
  const HeadWidget({
    Key key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.dmSans(
        color: Colors.white54,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
