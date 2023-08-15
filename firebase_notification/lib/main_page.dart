import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:logging/logging.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _token = '';

  _onPressedTokenSave() async {
    int? status = await _saveToken();

    developer.log('status : $status',
        level: Level.INFO.value, name: '_onPressedTokenSave');
  }

  Future<String?> getToken() async {
    FirebaseMessaging fbMsg = FirebaseMessaging.instance;
    return await fbMsg.getToken();
  }

  _loadToken() async {
    _token = await getToken();
    setState(() {
      _token = _token;
    });
  }

  _showDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SelectableText(_token!),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('확인'))
            ],
          );
        });
  }

  Future<int?> _saveToken() async {
    if (_token == null || _token!.isEmpty) {
      developer.log('token is null or emptry', level: Level.WARNING.value);
      return null;
    }

    var url = Uri.https('localhost:8080', '/profile/token');
    int statusCode = 0;
    try {
      await http.post(url, body: {
        'token': _token
      }, headers: {
        'user-id': 'test-user-id',
        'profile-id': 'test-profile-id',
      }).then((value) => statusCode = value.statusCode);
    } on http.ClientException catch (e) {
      developer.log('error msg : ${e.message}',
          level: Level.WARNING.value, name: '_saveToken');
      return HttpStatus.internalServerError;
    } catch (e) {
      developer.log('error : $e', level: Level.WARNING.value);
      return HttpStatus.internalServerError;
    }

    return statusCode;
  }

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Firebase Message',
              style: TextStyle(fontSize: 18, color: Colors.black)),
          backgroundColor: Colors.amber.shade300),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showDialog(context, 'Token 확인');
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber.shade300)),
                    child: Text('Token 확인',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                ),
              ],
            ),
            //
            SizedBox(height: 20),

            // Token값 저장
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onPressedTokenSave,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber.shade300)),
                    child: Text('Token 저장',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
