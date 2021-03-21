import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Models/onboarding.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<StepModel> list = StepModel.list;
  final _controller = PageController();
  int initialPage = 0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page.round();
      });
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: Column(
          children: <Widget>[
            _appBar(),
            _body(_controller),
            _indicator(),
          ],
        ),
      ),
    );
  }

  Expanded _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              if (index == 1) _displayText(list[index].text) else _displayImage(list[index].url),
              const SizedBox(
                height: 25,
              ),
              if (index == 1) _displayImage(list[index].url) else _displayText(list[index].text),
            ],
          );
        },
      ),
    );
  }

  Container _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (initialPage > 0) {
                _controller.animateToPage(initialPage - 1,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn);
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (initialPage < list.length) {
                _controller.animateToPage(
                  list.length,
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(
              "Skip",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _indicator() {
    return Container(
      width: 90,
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: <Widget>[
          Align(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                value: (initialPage + 1) / (list.length + 1),
              ),
            ),
          ),
          Align(
            child: GestureDetector(
              onTap: () {
                if (initialPage < list.length) {
                  _controller.animateToPage(initialPage + 1,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                }
                if (initialPage == 2) {
                  Get.to(
                    const Wrapper(),
                  );
                }
              },
              child: Container(
                width: 65,
                height: 65,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _displayText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  CachedNetworkImage _displayImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: MediaQuery.of(context).size.height * .5,
    );
  }
}
