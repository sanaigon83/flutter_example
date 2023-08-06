import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nogari_chat/screen/main_screen.dart';

Future<void> main() async {
  //Firebase 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginSigninScreen(),
    );
  }
}
