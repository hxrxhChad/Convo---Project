import 'package:flutter/material.dart';

import '../ui/screens/index.dart';
import 'index.dart';

class Routes {
  Routes();

  static List<PageModel> routes() {
    return [
      PageModel(route: Pages.initial, page: const AuthScreen()),
      PageModel(route: Pages.chat, page: const ChatScreen()),
      PageModel(route: Pages.settings, page: const SettingsScreen()),
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

    // todo modify here
    return MaterialPageRoute(
        builder: (_) => const Column(), settings: settings);
  }
}
