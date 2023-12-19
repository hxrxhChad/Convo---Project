import 'package:chat_alpha_sept/debug/hall_page.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';
import '../ui/screens/screens.dart';
import 'utils.dart';

class Routes {
  Routes();
  static List<PageModel> routes() {
    return [
      const PageModel(route: Pages.initial, page: HallPage()),
      const PageModel(route: Pages.register, page: RegisterScreen()),
      const PageModel(route: Pages.auth, page: AuthScreen()),
      const PageModel(route: Pages.chat, page: ChatScreen()),
      const PageModel(route: Pages.message, page: MessageScreen()),
      const PageModel(route: Pages.setting, page: SettingScreen())
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
