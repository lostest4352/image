import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/models/theme_settings.dart';
import 'package:image/routes/routes.dart';

void main() {
  // Dark navigation bar. Code may give issues.
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(61, 0, 0, 0),
    ));
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(themeProvider);
    return MaterialApp(
      theme: darkMode ? darkTheme : lightTheme,
      initialRoute: RouteManager.mainPage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
