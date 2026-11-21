import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nots/db/database-helper.dart';
import 'package:nots/pages/Create_note.dart';
// import 'package:nots/pages/Home-page.dart';
// import 'package:nots/pages/insert-todo.dart';
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
  final database = DatabaseHelper();
  List<Map<String, dynamic>> allNotes = [];
  Future<void> fetchNotes() async {
    final notes = await database.getNote();
    setState(() {
      allNotes = notes;
    });
  }

  dynamic _locale = Locale("en");
  Map<String, dynamic> _localization = {};
  @override
  void initState() {
    super.initState();
    fetchNotes();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final file = _locale.languageCode == "en"
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = await rootBundle.loadString(file);
    _localization = jsonDecode(rawData);
  }

  void ChangeLanguage(String newLanguage) async {
    final file = newLanguage == "en"
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = await rootBundle.loadString(file);
    setState(() {
      _locale = Locale(newLanguage);
      _localization = jsonDecode(rawData);
    });
  }

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
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey.shade200,
              title: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Notes",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight(24),
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.grey.shade200,
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: allNotes.length,
                itemBuilder: (context, index) {
                  final dateToString = DateTime.parse(
                    allNotes[index]["created_at"],
                  );
                  final finalDate = DateFormat("yyyy - MM - dd HH:mm:ss")
                      .format(dateToString);
                  return Card(
                    color: Colors.white,
                    shadowColor: Colors.grey.shade400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(color: Colors.grey.shade600),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allNotes[index]["title"],
                              style: TextStyle(
                                fontSize: 21,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              finalDate.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createNote()),
                );
              },
              child: Icon(Icons.mode_edit_outline_outlined),
            ),
          ),
        );
      },
    );
  }
}
// Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.blueGrey,
//               foregroundColor: Colors.white,
//               title: Text(_localization["appBar_title"] ?? "Notes"),
//             ),
//             drawer: Drawer(
//               child: Column(
//                 children: [
//                   DrawerHeader(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           _localization["appBar-title"] ?? "",
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.home),
//                     title: Text(_localization["Home_Page"] ?? ""),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.add_task_outlined),
//                     title: Text(_localization["add_note"] ?? ""),
//                     onTap: () {
//                       // Navigator.push(context, )
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => createNote()),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings),
//                     title: Text(_localization["settings"] ?? ""),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.language_outlined),
//                     title: Text(
//                       _locale.languageCode == "en" ? "فارسی" : "English",
//                     ),
//                     onTap: () {
//                       ChangeLanguage(
//                         _locale.languageCode == "en" ? "fa" : "en",
//                       );
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(12),
//               child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: allNotes.length,
//                 itemBuilder: (context, index) {
//                   final dateToString = DateTime.parse(
//                     allNotes[index]["created_at"],
//                   ).toString();
//                   return Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             allNotes[index]["title"],
//                             style: TextStyle(fontSize: 21),
//                           ),
//                           Text(
//                             dateToString,
//                             style: TextStyle(
//                               color: Colors.grey.shade400,
//                               fontWeight: FontWeight(12),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Center(child: Text(_localization["title"] ?? "")),
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => createNote()),
//     );
//   },
//   child: Icon(Icons.mode_edit_outline_outlined),
// ),
//           ),
