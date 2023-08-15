import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  // 초기값
  final int price = 2000;

  // Stream Builder에서 사용할 Stream을 지정
  Stream<int> addStreamValue() {
    return Stream<int>.periodic(Duration(seconds: 1), (count) => price + count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
          centerTitle: true,
        ),
        body: Center(
            child: StreamBuilder<int>(
          initialData: price,
          stream: addStreamValue(),
          builder: (context, snapshot) {
            return Text(
              'Price: ${snapshot.data}',
              style: const TextStyle(fontSize: 24),
            );
          },
        )));
  }
}
