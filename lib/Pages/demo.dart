import 'package:flutter/material.dart';
import 'package:my_app/Models/EducationModel/education_model.dart';
import 'package:my_app/State/BackendProvider/backend_provider.dart';
import 'package:provider/provider.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<EducationModel>(
        future: Provider.of<BackendProvider>(context, listen: false)
            .getUserEducationData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.education.length,
              itemBuilder: (context, index) {
                final data = snapshot.data;
                final education = snapshot.data.education[index];
                return Text(education.name);
              },
            );
          }
        },
      ),
    );
  }
}
