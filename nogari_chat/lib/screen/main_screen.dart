import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nogari_chat/config/palette.dart';

class LoginSigninScreen extends StatefulWidget {
  const LoginSigninScreen({super.key});

  @override
  State<LoginSigninScreen> createState() => _LoginSigninScreenState();
}

class _LoginSigninScreenState extends State<LoginSigninScreen> {
  bool _isSignUpScreen = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: Stack(
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
                height: _isSignUpScreen == true ? 280 : 250,
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
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Palette.textColor1,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(10.0),
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
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    contentPadding: EdgeInsets.all(10)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.textColor1, width: 0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Palette.textColor1),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.textColor1, width: 0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.textColor1, width: 0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: Icon(Icons.key_outlined),
                                  hintText: "비밀번호",
                                  hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Palette.textColor1),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.textColor1, width: 0.5),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_isSignUpScreen == false)
                      Container(
                        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor1, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(Icons.email),
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                    fontSize: 15.0, color: Palette.textColor1),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor1, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor1, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(Icons.key_outlined),
                                hintText: "비밀번호",
                                hintStyle: TextStyle(
                                    fontSize: 15.0, color: Palette.textColor1),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor1, width: 0.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                      )
                  ],
                ),
              ),
            ),
            // 전송버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              top: _isSignUpScreen == true ? 430 : 400,
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
            //
            Positioned(
                top: MediaQuery.of(context).size.height * 0.60,
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
                ))
          ],
        ),
      ),
    );
  }
}
