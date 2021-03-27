import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';
import 'package:my_app/Widget/constants.dart';

class Dynamic404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ExtendedImage.network(
              "https://i.pinimg.com/originals/b4/be/ad/b4beadb8bcd5866a133250a46e317f3a.png",
              height: MediaQuery.of(context).size.height / 4,

              // color: Colors.white,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "What you're looking may have been misplaced\nin Long Term Memory.",
              //jost,space Grotesk,crimson pro,great vibes,redHatDisplay
              style: GoogleFonts.crimsonPro(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 22.0),
              child: TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Get.offAll(
                    () => const Wrapper(),
                  );
                },
                child: Text(
                  "🔙 Back to Home?",
                  //jost,space Grotesk,crimson pro,great vibes,redHatDisplay
                  style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
