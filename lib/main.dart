import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nots/pages/Home-page.dart';
import 'package:nots/theme/dark-mode.dart';
import 'package:nots/theme/light-mode.dart';
import 'package:nots/theme/theme-provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  dynamic _locale = Locale("en");
  Map<String, dynamic> _localization = {};
  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final file = _locale.languageCode == "en"
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = await rootBundle.loadString(file);
    _localization = jsonDecode(rawData);
  }

  // void ChangeLanguage(String newLanguage) async {
  //   final file = _locale.languageCode == "en"
  //       ? "assets/l10n/en.json"
  //       : "assets/l10n/fa.json";
  //   final rawData = await rootBundle.loadString(file);
  //   setState(() {
  //     _locale = Locale("en");
  //     _localization = jsonDecode(rawData);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: [Locale("en"), Locale("fa")],
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              title: Text(_localization["appBar_title"] ?? "Notes"),
              actions: [
                MaterialButton(
                  onPressed: () async {
                    final file = _locale.languageCode == "en"
                        ? "assets/l10n/en.json"
                        : "assets/l10n/fa.json";
                    final rawData = await rootBundle.loadString(file);
                    setState(() {
                      _locale = Locale("en");
                      _localization = jsonDecode(rawData);
                    });
                  },
                  child: Text("English"),
                ),
                MaterialButton(
                  onPressed: () async {
                    final file = _locale.languageCode == "en"
                        ? "assets/l10n/en.json"
                        : "assets/l10n/fa.json";
                    final rawData = await rootBundle.loadString(file);
                    setState(() {
                      _locale = Locale("fa");
                      _localization = jsonDecode(rawData);
                    });
                  },
                  child: Text("فارسی"),
                ),
              ],
            ),
            body: Center(child: Text(_localization["title"])),
          ),
        );
      },
    );
  }
}
