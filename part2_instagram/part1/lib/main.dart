import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  @override
  Widget build(BuildContext context) {
    // 음식 사진 데이터
    List<Map<String, dynamic>> dataList = [
      {
        "category": "수제버거",
        "imgUrl":
        "https://i.ibb.co/HBGKYn4/foodiesfeed-com-summer-juicy-beef-burger.jpg",
      },
      {
        "category": "건강식",
        "imgUrl":
        "https://i.ibb.co/mB5YNs2/foodiesfeed-com-pumpkin-soup-with-pumpkin-seeds-on-top.jpg",
      },
      {
        "category": "한식",
        "imgUrl":
        "https://i.ibb.co/Kzzpc97/Beautiful-vibrant-shot-of-traiditonal-Korean-meals.jpg",
      },
      {
        "category": "디저트",
        "imgUrl":
        "https://i.ibb.co/DL5vJVZ/foodiesfeed-com-carefully-putting-a-blackberry-on-tiramisu.jpg",
      },
      {
        "category": "피자",
        "imgUrl": "https://i.ibb.co/qsm8QH4/pizza.jpg",
      },
      {
        "category": "볶음밥",
        "imgUrl":
        "https://i.ibb.co/yQDkq2X/foodiesfeed-com-hot-shakshuka-in-a-cast-iron-pan.jpg",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //  그림자 제거
        backgroundColor: Colors.white,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        // 아이콘 색상 변경
        title: Text(
          "Food Delivery",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("go my page");
              },
              icon: Icon(Icons.person_outline))
        ],
      ),
      body: Column(
        // 수직으로 나열하는 위젯 수평은 row
        children: [
          // 검색
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "상품을 검색해주세요.",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  // 돋보기 아이콘
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("돋보기 아이콘 클릭");
                    },
                  )),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            thickness: 2.0,
          ),
          // 카테고리 목록
          Expanded(
              child: ListView.builder(
                  itemCount: dataList.length, // 데이터 개수
                  itemBuilder: (context, index) {
                    // dataList에서 index에 해당하는 데이터 꺼내기
                    Map<String, dynamic> data = dataList[index];
                    String category = data["category"];
                    String imgUrl = data["imgUrl"];

                    //카드 형태의 위젯
                    return Card(
                        margin: const EdgeInsets.all(8),
                        //위젯들을 위로 중첩하기 위해 Stackk 위젯 사용
                        child: Stack(
                          alignment: Alignment.center, // 중앙 정렬
                          children: [
                            // 배경 이미지
                            Image.network(
                              imgUrl,
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover, //
                            ),

                            // 배경 위에 글씨가 보이도롣 반투명한 박스 추가
                            Container(
                              width: double.infinity,
                              height: 120,
                              color: Colors.black.withOpacity(0.5),
                            ),

                            // 카테고리
                            Text(
                              category,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            )
                          ],
                        ));
                  }))
        ],
      ),
      drawer: Drawer(
        child: Column(children: [
          //Drawer 윗부분
          DrawerHeader(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(color: Colors.amber),
            child: SizedBox(
              width: double.infinity, //가로폭을 꽉 채우기
              child: Column(
                children: [
                  // 동그란 배경
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                        width: 62,
                      ),
                    ),
                  ),

                  // 닉네임 상단여백
                  SizedBox(
                    height: 16,
                  ),

                  // 닉네임
                  Text(
                    "닉네임",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "hello@world.com",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          // 이벤트 배너
          // 특정 비율로 위젯을 보여주기
          AspectRatio(
            aspectRatio: 12 / 4,
            /// 이벤트 배너 리스트
            /// 스크롤을 하는데, 특정 항목이 스냅이 걸리도록 만들고 싶은 경우 PageView를 사용한다.
            child: PageView(
              children: [
                Image.network(
                  "https://i.ibb.co/Q97cmkg/sale-event-banner1.jpg",
                ),
                Image.network(
                  "https://i.ibb.co/GV78j68/sale-event-banner2.jpg",
                ),
                Image.network(
                  "https://i.ibb.co/R3P3RHw/sale-event-banner3.jpg",
                ),
                Image.network(
                  "https://i.ibb.co/LRb1VYs/sale-event-banner4.jpg",
                ),
              ],
            ),
          ),

          // 구매내역
          ListTile(
            title: Text(
              '구매내역',
              style: TextStyle(fontSize: 18),
            ),

            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              /// 클릭시 drawer 닫기
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              '저장한 레시피',
              style: TextStyle(fontSize: 18),
            ),

            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              /// 클릭시 drawer 닫기
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}