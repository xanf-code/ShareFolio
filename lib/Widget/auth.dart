import 'package:flutter/material.dart';
import 'package:my_app/Services/auth_service.dart';

class Providers extends InheritedWidget {
  final AuthService auth;
  final db;

  Providers({Key key, Widget child, this.auth, this.db})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Providers of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Providers>());
}
