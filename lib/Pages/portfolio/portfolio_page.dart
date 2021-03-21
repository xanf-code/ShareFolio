import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Widget/constants.dart';

class ShareFolioPage extends StatelessWidget {
  final String uid;

  const ShareFolioPage({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            final userDocument = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                Text(
                  userDocument["name"].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                Text(
                  userDocument["email"].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
