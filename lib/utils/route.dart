import 'package:flutter/material.dart';

import '../model/model.dart';
import '../ui/screens/screens.dart';

class Routes {
  static const initial = '/';
  static const auth = '/auth';
  static const register = '/register';
  static const chat = '/chat';
  static const message = '/message';
  static const setting = '/setting';
  Routes();
  static List<PageModel> routes() {
    return [
      const PageModel(route: initial, page: AuthScreen()),
      const PageModel(route: auth, page: AuthScreen()),
      const PageModel(route: register, page: RegisterScreen()),
      const PageModel(route: chat, page: ChatScreen()),
      const PageModel(route: message, page: MessageScreen()),
      const PageModel(route: setting, page: SettingScreen())
    ];
  }

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }

    // todo modify here (error page)
    return MaterialPageRoute(
        builder: (_) => const Scaffold(), settings: settings);
  }
}
