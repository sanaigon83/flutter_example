// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'diary_service.dart';
import 'home_page.dart';


/**
 * 선택한 날짜에 일기 작성하기 
 * 날짜를 선택하면 해당 날짜의 일기 보여주기 
 * 일기를 클릭하여 수정하기 
 * 일기를 길게 클릭하여 삭제하기 
 * 
 * 
 */

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DiaryService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}