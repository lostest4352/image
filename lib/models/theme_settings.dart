import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark();

final themeProvider = StateNotifierProvider<ThemeSettingsNotifier, bool>(
    (ref) => ThemeSettingsNotifier());

class ThemeSettingsNotifier extends StateNotifier<bool> {
  ThemeSettingsNotifier() : super(true) {
    initializePrefs();
  }

  late SharedPreferences preferences;

  Future initializePrefs() async {
    preferences = await SharedPreferences.getInstance();
    var darkMode = preferences.getBool("darkMode");
    state = darkMode ?? true;
  }

  void toggle() async {
    state = !state;
    preferences.setBool("darkMode", state);
  }
}
