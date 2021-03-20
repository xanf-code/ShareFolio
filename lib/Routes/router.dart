import 'package:auto_route/auto_route.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';
import 'package:my_app/Pages/settings/setings.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: Settings,
      path: '/settings',
    ),
    AutoRoute(
      page: Wrapper,
      path: '/',
      initial: true,
    )
  ],
)
class $AppRouter {}
