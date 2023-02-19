import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/theme_settings.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings Page"),
          leading: IconButton(
              onPressed: () {
                return Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final darkThemeToggle = ref.watch(themeProvider);
            return Column(
              children: [
                Card(
                  child: SwitchListTile(
                    title: const Text("Dark Theme"),
                    
                    value: darkThemeToggle,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).toggle();
                    },
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
