import 'package:connectivity/connectivity.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Functions {
  void connectivityStatus(context) {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "No Internet connection, You are offline now.",
            ),
          );
        }
      },
    );
  }
}
