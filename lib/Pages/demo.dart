import 'package:flutter/material.dart';
import 'package:my_app/Models/EducationModel/education_model.dart';
import 'package:my_app/Models/SkillsModel/skills_model.dart';
import 'package:my_app/Models/UserAboutModel/about_model.dart';
import 'package:my_app/State/BackendProvider/backend_provider.dart';
import 'package:provider/provider.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EducationWidget(),
          ShareFolioWidget(),
          SkillsWidget(),
        ],
      ),
    );
  }
}

class EducationWidget extends StatelessWidget {
  const EducationWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EducationModel>(
      future: Provider.of<BackendProvider>(context, listen: false)
          .getUserEducationData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.education.length,
            itemBuilder: (context, index) {
              final data = snapshot.data;
              final education = snapshot.data.education[index];
              return Text(education.name);
            },
          );
        }
      },
    );
  }
}

class ShareFolioWidget extends StatelessWidget {
  const ShareFolioWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AboutModel>(
      future: Provider.of<BackendProvider>(context, listen: false)
          .getUserAboutData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Text(snapshot.data.bio);
        }
      },
    );
  }
}

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SkillsModel>(
      future: Provider.of<BackendProvider>(context, listen: false)
          .getUserSkillsData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.skills.length,
            itemBuilder: (context, index) {
              final skills = snapshot.data.skills[index];
              return Text(skills.toString());
            },
          );
        }
      },
    );
  }
}
