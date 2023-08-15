import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quiz = "";

  @override
  void initState() {
    quiz = "Let's Start Quiz";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.pinkAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // quiz
              Expanded(
                child: Center(
                  child: Text(
                    quiz,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // New Quiz 버튼
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  child: Text(
                    "New Quiz",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 24,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () async {
                    // New Quiz 클릭시 퀴즈 가져오기
                    Response result =
                        await Dio().get("http://numbersapi.com/random/trivia");
                    setState(() {
                      quiz = result.data;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
