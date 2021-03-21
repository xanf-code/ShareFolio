import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Functions {
  void connectivityStatus(BuildContext context) {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          showTopSnackBar(
            context,
            const CustomSnackBar.error(
              message: "No Internet connection, You are offline now.",
            ),
          );
        }
      },
    );
  }
}
