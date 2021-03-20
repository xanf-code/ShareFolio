// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../Pages/settings/setings.dart' as _i2;
import '../Pages/Wrapper/wrapper.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    Settings.name: (entry) {
      var args =
          entry.routeData.argsAs<SettingsArgs>(orElse: () => SettingsArgs());
      return _i1.MaterialPageX(
          entry: entry,
          child: _i2.Settings(text: args.text),
          maintainState: true,
          fullscreenDialog: false);
    },
    Wrapper.name: (entry) {
      return _i1.MaterialPageX(
          entry: entry,
          child: const _i3.Wrapper(),
          maintainState: true,
          fullscreenDialog: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(Settings.name,
            path: '/settings', fullMatch: false, usesTabsRouter: false),
        _i1.RouteConfig(Wrapper.name,
            path: '/', fullMatch: false, usesTabsRouter: false)
      ];
}

class Settings extends _i1.PageRouteInfo<SettingsArgs> {
  Settings({this.text})
      : super(name, path: '/settings', args: SettingsArgs(text: text));

  final String text;

  static const String name = 'Settings';
}

class SettingsArgs {
  const SettingsArgs({this.text});

  final String text;
}

class Wrapper extends _i1.PageRouteInfo {
  const Wrapper() : super(name, path: '/');

  static const String name = 'Wrapper';
}
