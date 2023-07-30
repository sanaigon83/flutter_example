import 'package:flutter/material.dart';
import 'package:miso_starbucks/starbucks/firstpage/firstMainSliverToBox.dart';

// 메인 색상
Color starbucksPrimaryColor = Color.fromARGB(255, 83, 184, 138);

// 포인트 색상
Color starbucksAccentColor = Color.fromARGB(255, 199, 176, 121);

class Starbucks extends StatefulWidget {
  const Starbucks({super.key});

  @override
  State<Starbucks> createState() => _StarbucksState();
}

class _StarbucksState extends State<Starbucks> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          StarbucksFirstPage(),
          StarbucksSecondPage(),
          StarbucksThirdPage(),
          Center(
            child: (Text("Starbucks 네 번째 페이지")),
          ),
          Center(
            child: (Text("Starbucks 다섯 번째 페이지")),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: starbucksPrimaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false, // 선택되지 않은 아이콘에도 라벨 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않게
        backgroundColor: Colors.white.withOpacity(0.8),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.free_breakfast),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: '',
          ),
        ],
      ),
    );
  }
}

class StarbucksFirstPage extends StatelessWidget {
  const StarbucksFirstPage({super.key});

  /// 배경 이미지 URL
  final String backImg =
      "https://i.ibb.co/2Pz33q7/2021-12-16-12-21-42-cleanup.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 우측 하단에 Deliveys 아이콘을 띄우기 위해 Stack으로 구현
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                // 뒤로가기 버튼 숨기기
                automaticallyImplyLeading: false,
                pinned: true, //bottom 영역 남기기
                snap: false, // 중간에 멈출때 자동으로 AppBar를 펼처서 배경을 모두 보여줄기
                floating: true, // 앱바를 화면에 띄울지, 아니면 컬럼처럼 최상단에 놓을지
                expandedHeight: 252,
                backgroundColor: Colors.white,

                // 스크롤시 사라지는 영역

                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      // 백그라운드 이미지
                      Positioned.fill(
                        bottom: 60,
                        child: Image.network(backImg, fit: BoxFit.fill),
                      ),
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "한 핸의 마무리,\n수고 많았어요💖",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "11 ★ until next Reward",
                                        style: TextStyle(
                                            color: starbucksAccentColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),

                                      // Tip: LinearProgressIndicatora는 각져있는데 둥글게 처리
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: LinearProgressIndicator(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.2),
                                          value: 0.083,
                                          minHeight: 10,
                                          valueColor: AlwaysStoppedAnimation(
                                              starbucksAccentColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 28, color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: "1",
                                          style: TextStyle(
                                              fontSize: 38,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text: "/",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                          text: "12 ★",
                                          style: TextStyle(
                                              color: starbucksAccentColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // 스크롤시 남아있는 영역
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(52), // 영역높이,
                  child: Container(
                    height: 52,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("클릭");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mail_lock_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "What's new",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          GestureDetector(
                            onTap: () {
                              print("클릭2");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.confirmation_num_outlined,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Coupon",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),

                          //
                          Stack(
                            children: [
                              Icon(
                                Icons.notifications_outlined,
                                color: Colors.grey,
                                size: 32,
                              ),
                              Positioned(
                                right: 2,
                                top: 2,
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: starbucksPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Tip : CustomScrollView 안에서는 모든 첫 번째 위젯이 Sliver로 구현 되어야합니다.
              /// SliverToBoxAdapter는 Container 같은 위젯이라고 보시면 됩니다.
              FirstMainSliverToBox().build(context)
            ],
          ),
          // Deliverys
          Positioned(
            bottom: 18,
            right: 24,
            child: GestureDetector(
              onTap: () {
                print("클릭 딜리버리");
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: starbucksPrimaryColor,
                  borderRadius: BorderRadius.circular(64),
                ),
                child: Row(
                  children: [
                    Text("Deliverys",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.pedal_bike_outlined,
                        color: Colors.white, size: 28),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarbucksSecondPage extends StatelessWidget {
  const StarbucksSecondPage({super.key});

  /// 카드 이미지
  final String cardImgUrl = "https://i.ibb.co/BgfYHg4/2021-12-16-1-49-51.png";

  Widget? cardItemBuilder(context, index) {
    return Container(
      child: Image.network(cardImgUrl),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                spreadRadius: 1,
                blurRadius: 6)
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Pay",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          actions: [
            Icon(
              Icons.list_rounded,
              color: Colors.grey,
            )
          ]),
      body: Column(
        children: [
          // Card
          /// Tip : 스크롤하는데 스냅이 걸려서 해당 항목이 화면 중앙에 보이는 경우 PageView를 사용하면 됨.
          Expanded(
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.85),
              itemCount: 10,
              itemBuilder: cardItemBuilder,
            ),
          ),

          // Coupon & e-Gift Item
          Container(
            height: 72,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("쿠폰 선택");
                    },
                    child: Text(
                      "Coupon",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  height: 12,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("기프트 버튼 클ㄹ릭");
                    },
                    child: Text(
                      "e-Gift Item",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StarbucksThirdPage extends StatelessWidget {
  const StarbucksThirdPage({super.key});

  /// 전체 메뉴
  final List<Map<String, String>> menu = const [
    {
      "ko": "추천",
      "en": "Recommend",
      "imgUrl": "https://i.ibb.co/SwGPpzR/9200000003687-20211118142543832.jpg",
    },
    {
      "ko": "리저브 에스프레소",
      "en": "Reserve Espresso",
      "imgUrl": "https://i.ibb.co/JHVXZ72/9200000003690-20211118142702357.jpg",
    },
    {
      "ko": "리저브 드립",
      "en": "Reserve Drip",
      "imgUrl": "https://i.ibb.co/M91G17c/9200000003693-20211118142933650.jpg",
    },
    {
      "ko": "콜드브루",
      "en": "ColdBrew",
      "imgUrl": "https://i.ibb.co/jyZK4C9/9200000003696-20211118143125337.jpg",
    },
  ];

  Widget MyItemBuilder(BuildContext context, int index) {
    final item = menu[index % menu.length];
    final ko = item["ko"] ?? "제목";
    final en = item["en"] ?? "title";
    final imageUrl = item["imgUrl"] ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 21),
      child: GestureDetector(
        onTap: () {
          print("$index 를 클릭");
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ko,
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                Text(
                  en,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Order", style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
              onPressed: () {
                print("search");
              },
              icon: Icon(Icons.search, color: Colors.black),
            ),
          ],
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: starbucksPrimaryColor,
            indicatorWeight: 4,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "전체 메뉴"),
              Tab(text: "나만의 메뉴"),
              Tab(text: "홀 케이크"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(itemCount: 100, itemBuilder: MyItemBuilder),
            ListView.builder(itemCount: 100, itemBuilder: MyItemBuilder),
            ListView.builder(itemCount: 100, itemBuilder: MyItemBuilder)
          ],
        ),
      ),
    );
  }
}
