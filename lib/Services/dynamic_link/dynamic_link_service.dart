import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/portfolio/portfolio_page.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDynamicLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      _handleDynamicLink(dynamicLinkData);
    }, onError: (OnLinkErrorException e) async {
      debugPrint("Dynamic link failed : ${e.message}");
    });
  }

  Future<String> createUserLink(String userID) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://sfolio.page.link",
      link: Uri.parse(
        "https://www.sharefolioapp.com/portfolio?user=$userID",
      ),
      androidParameters: AndroidParameters(
        packageName: "com.dglt.my_app",
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();

    return dynamicUrl.toString();
  }

  void _handleDynamicLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      debugPrint('$deepLink');

      final userID = deepLink.pathSegments.contains('portfolio');
      if (userID) {
        final userID = deepLink.queryParameters['user'];

        if (userID != null) {
          Get.to(
            ShareFolioPage(
              uid: userID,
            ),
          );
          debugPrint(userID);
        }
      }
    }
  }
}
