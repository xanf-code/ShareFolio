import 'package:flutter/material.dart';
import 'package:my_app/Models/user_about_sharefolio.dart';
import 'package:my_app/Services/Backend_calls/all_calls.dart';

class Demo extends StatelessWidget {
  final BackendCalls _backendCalls = BackendCalls();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserDataModel>(
          future: _backendCalls.getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data.name.toString(),
                  ),
                  Text(
                    snapshot.data.type.toString(),
                  ),
                  Text(
                    snapshot.data.bio.toString(),
                  ),
                  Text(
                    snapshot.data.location.toString(),
                  ),
                  Text(
                    snapshot.data.uUID.toString(),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
