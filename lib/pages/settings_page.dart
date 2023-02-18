import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/main.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Column(
            children: [
              Card(
                child: SwitchListTile(
                  title: const Text("Dark Theme"),
                  
                  value: false,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).toggle();
                  },
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
