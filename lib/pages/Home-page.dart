import 'package:flutter/material.dart';
import 'package:nots/pages/Settings.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      bottomNavigationBar: NavigationBar(
        elevation: 8,
        backgroundColor: Colors.white,
        selectedIndex: 0,
        onDestinationSelected: (value) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          }
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
      body: Center(child: Text("home page")),
    );
  }
}
