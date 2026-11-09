import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nots/theme/theme-provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode"),
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).isDarkMode,
                  onChanged: (value) => Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
