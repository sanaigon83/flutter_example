import 'package:flutter/material.dart';
import 'package:miso_starbucks/starbucks.dart';

import 'miso.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppListPage(),
    );
  }
}

class AppListPage extends StatelessWidget {
  const AppListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(children: [
        // 1. Miso
        ListTile(
          title: Text('1. Miso', style: TextStyle(fontSize: 24.0)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Miso()),
          ),
        ),

        // 2. Starbucks
        ListTile(
          title: Text('2. Startbucks', style: TextStyle(fontSize: 24.0)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Starbucks()),
          ),
        )
      ])),
    );
  }
}
