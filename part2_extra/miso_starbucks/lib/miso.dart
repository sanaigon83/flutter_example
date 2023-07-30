import 'package:flutter/material.dart';

// Miso의 메인색상
Color misoPrimaryColor = Color.fromARGB(255, 38, 103, 240);

class Miso extends StatefulWidget {
  const Miso({Key? key}) : super(key: key);

  @override
  _MisoState createState() => _MisoState();
}

class _MisoState extends State<Miso> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          MisoFirstPage(),
          MisoSecondPage(),
          MisoThridPage(),
          MisoFourthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: misoPrimaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않게
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class MisoFirstPage extends StatelessWidget {
  const MisoFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 42, 31, 251),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    // 문구
                    Text(
                      "대한 민국 1등 홈서비스\n 미소를 만나보세요!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),

                    // 예약하기 버튼
                    GestureDetector(
                        onTap: () {
                          print("예약하기 버튼 클릭");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: misoPrimaryColor),
                              SizedBox(width: 6),
                              Text(
                                "예약하기",
                                style: TextStyle(
                                  color: misoPrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 350),
                    // 서비스 상세정보
                    Positioned(
                        bottom: 32,
                        child: GestureDetector(
                            onTap: () {
                              print("서비스 상세정보 클릭");
                            },
                            child: Container(
                              color: Colors.white.withOpacity(0.3),
                              padding: EdgeInsets.all(12),
                              child: Text("서비스 상세정보",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class MisoSecondPage extends StatelessWidget {
  const MisoSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  // 컬럼을 기본적으로 중앙 정렬로 되어있으니 이를 start 지점으로 변경해야 한다.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tip : 기기 높이의 %로 줘야 각 기기별로 적절한 위치에 배치할 수 있음.
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                    // 예약내역
                    Text("예약내역",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w900)),

                    SizedBox(height: 64),

                    Row(
                      children: [
                        // 아이콘
                        Icon(Icons.error, color: misoPrimaryColor),
                        SizedBox(width: 8),

                        //예약된 서비스가 아직 없어요. 지금 예약해보세요!
                        //Tip : 폰의 폭과 관계없이 텍스트를 한 줄로 보여주기
                        Expanded(
                            // row의 남은 영역을 모두 차지하도록
                            child: FittedBox(
                          // 해당 영역에 적절한 사이즈로 맞추기
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "예약된 서비스가 아직 없어요. 지금 예약해보세요!",
                            style: TextStyle(
                              fontSize: 100, // 아무리커도 한 줄로 보인다.
                            ),
                          ),
                        )),
                      ],
                    ),
                    Divider(color: Colors.grey),
                  ],
                ),
              ),

              // 예약하기 추가
              Positioned(
                  bottom: 18,
                  left: 24,
                  right: 24,
                  child: GestureDetector(
                    onTap: () {
                      print("예약하기 버튼 클릭");
                    },
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: misoPrimaryColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: Text(
                        "예약하기",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MisoThridPage extends StatelessWidget {
  const MisoThridPage({super.key});

  /// 세 번째 화면 배경 이미지 URL
  final String backgroundImgUrl =
      "https://i.ibb.co/rxzkRTD/146201680-e1b73b36-aa1e-4c2e-8a3a-974c2e06fa9d.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: misoPrimaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Image.network(backgroundImgUrl),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 28, height: 1.5, color: Colors.white),
                          children: [
                            TextSpan(
                              text: "친구 추천할 때마다\n",
                            ),
                            TextSpan(
                                text: "10,000원 ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "할인 쿠폰 지급!"),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          print("자세히보기 버튼 클릭");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("자세히보기",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            Icon(Icons.arrow_forward_ios,
                                size: 12, color: Colors.white)
                          ],
                        ),
                      )
                    ]),
              ),
              Positioned(
                bottom: 30,
                child: GestureDetector(
                  onTap: () {
                    print("친구 추천하기 버튼 클릭");
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add, color: misoPrimaryColor),
                        SizedBox(width: 10),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "친구 추천하기",
                            style: TextStyle(
                                color: misoPrimaryColor, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MisoFourthPage extends StatelessWidget {
  const MisoFourthPage({super.key});

  final String phoneNumber = "010-1234-5678";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 62),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("나의 정보",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 16,
              ),
              Text(phoneNumber,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 32,
              ),
              ListTile(
                onTap: () {
                  print("주소 관리 클릭");
                },
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.home_outlined, color: Colors.black),
                title: Text(
                  "주소 관리",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () {
                  print("결제 수단 관리 클릭 죔");
                },
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.credit_card_outlined, color: Colors.black),
                title: Text(
                  "결제 수단 관리",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () {
                  print("공지사항 클릭 됨");
                },
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.volume_mute_outlined, color: Colors.black),
                title: Text(
                  "공지사항",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                onTap: () {
                  print("문의사항 클릭됨");
                },
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.help_outline, color: Colors.black),
                title: Text(
                  "문의사항",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
