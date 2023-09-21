import 'package:flutter/material.dart';

class Pages {
  static const initial = '/';
  static const chat = 'chat';
  static const message = 'message';
  static const settings = 'settings';
}

class PageModel {
  String route;
  Widget page;

  PageModel({required this.route, required this.page});
}
