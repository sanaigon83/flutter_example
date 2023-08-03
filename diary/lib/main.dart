import 'package:diary/diaryService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage';

void main() {
  // multi-provider를 사용한다.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DiaryService>(
            create: (context) => DiaryService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
