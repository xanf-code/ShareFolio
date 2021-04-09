import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_app/State/BackendProvider/backend_provider.dart';
import 'package:my_app/constants.dart';
import 'package:provider/provider.dart';

class AddCards extends StatefulWidget {
  @override
  _AddCardsState createState() => _AddCardsState();
}

class _AddCardsState extends State<AddCards> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController sharefolioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextButton(
              onPressed: () {
                log("Tapped");
                addCards();
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  void addCards() {
    setState(() {
      Provider.of<BackendProvider>(context, listen: false).addUserCards(
        "ApKAoRMiTzZyCx2hWqEp79SWUcy1",
        "name",
        'title2',
        'company',
        'email',
        'phno',
        'fb',
        'twitter',
        'insta',
        'linkedin',
        'shareFolio',
      );
    });
  }
}
