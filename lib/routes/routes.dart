import 'package:flutter/material.dart';
import 'package:image/pages/settings_page.dart';

import '../pages/main_page.dart';


class RouteManager {
  static const String mainPage = '/';
  static const String settingsPage = '/settings';
  static const String imagePage = '/imagePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );
      case settingsPage:
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
        );
      

      default:
        throw const FormatException("Route not found");
        
    }
  }
}