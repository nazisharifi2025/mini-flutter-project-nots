import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nots/pages/Home-page.dart';
import 'package:nots/theme/dark-mode.dart';
import 'package:nots/theme/light-mode.dart';
import 'package:nots/theme/theme-provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _locale = Locale("en");
  Map<String, dynamic> _localization = {};
  @override
  void initState() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final file = _locale == "en"
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = await rootBundle.loadString(file);
    _localization = await jsonDecode(rawData);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: HomePage(),
        );
      },
    );
  }
}
