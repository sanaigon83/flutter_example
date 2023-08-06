import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nogari_chat/config/palette.dart';
import 'package:nogari_chat/screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSigninScreen extends StatefulWidget {
  const LoginSigninScreen({super.key});

  @override
  State<LoginSigninScreen> createState() => _LoginSigninScreenState();
}

class _LoginSigninScreenState extends State<LoginSigninScreen> {
  final _authentication = FirebaseAuth.instance;
  bool _isSignUpScreen = false;
  bool _showSpinner = false;

  final _formKey = GlobalKey<FormState>();

  String userName = '';
  String userEmail = '';
  String userPassword = '';

  _tryValidation() {
    // 모든 폼 필드가 유효한지 확인
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      // 유효하다면 폼 필드 저장 (onSaved() 호출)
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    double singUpScreenHeight = 320;
    double singUpScreenButtonTop = 470;

    double logInScreenHeight = 250;
    double logInScreenButtonTop = 400;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: GestureDetector(
            onTap: () {
              // 키보드 숨기기
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                // 배경 이미지
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('image/red.png'), fit: BoxFit.fill),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 90, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Welcome ",
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 1.0,
                                  color: Colors.white),
                              children: const [
                                TextSpan(
                                  text: "to Nogari",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('가입을 계속해 주세요',
                              style: TextStyle(
                                  letterSpacing: 1.0, color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                ),
                // 텍스트 폼 필드
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  top: 180,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    padding: EdgeInsets.only(top: 20),
                    height: _isSignUpScreen == true
                        ? singUpScreenHeight
                        : logInScreenHeight,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15.0,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _isSignUpScreen == true
                                              ? Palette.textColor1
                                              : Palette.activeColor),
                                    ),
                                    if (_isSignUpScreen == false)
                                      Container(
                                        width: 55,
                                        height: 2,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    _isSignUpScreen = false;
                                  });
                                },
                              ),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _isSignUpScreen == false
                                              ? Palette.textColor1
                                              : Palette.activeColor),
                                    ),
                                    if (_isSignUpScreen == true)
                                      Container(
                                        width: 55,
                                        height: 2,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    _isSignUpScreen = true;
                                  });
                                },
                              )
                            ],
                          ),
                          if (_isSignUpScreen)
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      key: ValueKey(1),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 4) {
                                          return 'Please enter at least 4 characters';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userName = value!;
                                      },
                                      onChanged: (value) {
                                        userName = value;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                          hintText: "이름",
                                          hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Palette.textColor1),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.all(10)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      key: ValueKey(2),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.contains('@') == false) {
                                          return 'Please enter a valid email address';
                                        }

                                        return null;
                                      },
                                      onSaved: (value) {
                                        userEmail = value!;
                                      },
                                      onChanged: (value) {
                                        userEmail = value;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          prefixIcon: Icon(Icons.email),
                                          hintText: "E-mail",
                                          hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Palette.textColor1),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.all(10)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      key: ValueKey(3),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Please enter at least 6 characters';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userPassword = value!;
                                      },
                                      onChanged: (value) {
                                        userPassword = value;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          prefixIcon: Icon(Icons.key_outlined),
                                          hintText: "비밀번호",
                                          hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Palette.textColor1),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.all(10)),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // 로그인 시
                          if (_isSignUpScreen == false)
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      key: ValueKey(4),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.contains('@') == false) {
                                          return 'Please enter a valid email address';
                                        }

                                        return null;
                                      },
                                      onSaved: (value) {
                                        userEmail = value!;
                                      },
                                      onChanged: (value) {
                                        userEmail = value;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          prefixIcon: Icon(Icons.email),
                                          hintText: "E-mail",
                                          hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Palette.textColor1),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.all(10)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      key: ValueKey(5),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Please enter at least 6 characters';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        userPassword = value!;
                                      },
                                      onChanged: (value) {
                                        userPassword = value;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          prefixIcon: Icon(Icons.key_outlined),
                                          hintText: "비밀번호",
                                          hintStyle: TextStyle(
                                              fontSize: 15.0,
                                              color: Palette.textColor1),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Palette.textColor1,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.all(10)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                // 전송버튼
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  top: _isSignUpScreen == true
                      ? singUpScreenButtonTop
                      : logInScreenButtonTop,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            _showSpinner = true;
                          });
                          _tryValidation();
                          if (_isSignUpScreen) {
                            try {
                              final newUser = await _authentication
                                  .createUserWithEmailAndPassword(
                                      email: userEmail, password: userPassword);

                              // 유저 정보 저장
                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(newUser.user!.uid)
                                  .set({
                                'userName': userName,
                                'userEmail': userEmail,
                              });

                              if (newUser.user != null) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => ChatScreen(),
                                //     ));

                                setState(() {
                                  _showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                              setState(() {
                                _showSpinner = false;
                              });
                            }
                          } else {
                            try {
                              setState(() {
                                _showSpinner = true;
                              });
                              final logInUser = await _authentication
                                  .signInWithEmailAndPassword(
                                      email: userEmail, password: userPassword);

                              if (logInUser.user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(),
                                    ));

                                setState(() {
                                  _showSpinner = false;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                _showSpinner = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: const [
                                  Colors.orange,
                                  Colors.red,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0.0, 1.0),
                                )
                              ],
                            ),
                            child: Icon(Icons.arrow_forward,
                                color: Colors.white, size: 30)),
                      ),
                    ),
                  ),
                ),
                // google 로그인 버튼
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  top: _isSignUpScreen
                      ? MediaQuery.of(context).size.height * 0.75
                      : MediaQuery.of(context).size.height * 0.65,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Text(_isSignUpScreen == true
                          ? "혹은 Google로 가입하기"
                          : "혹은 Google로 로그인"),
                      SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Palette.googleColor,
                          minimumSize: Size(155, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        icon: Icon(Icons.add),
                        label: Text('Google'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
