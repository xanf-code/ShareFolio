import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/ShareFolio_CRUD/Update/update_education.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class DisplayEducation extends StatefulWidget {
  @override
  _DisplayEducationState createState() => _DisplayEducationState();
}

class _DisplayEducationState extends State<DisplayEducation> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(_authService.getCurrentUserUID().toString())
            .collection("shareFolio")
            .doc("details")
            .snapshots(),
        //builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {},
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: int.parse(snapshot.data["eduLength"].toString()),
            itemBuilder: (BuildContext context, int index) {
              var userDocument = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const UpdateEducation(),
                    );
                    debugPrint(userDocument["education"][index].toString());
                  },
                  child: Text(
                    userDocument["education"][index]["Name"].toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
