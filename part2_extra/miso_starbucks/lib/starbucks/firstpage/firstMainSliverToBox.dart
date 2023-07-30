import 'package:flutter/material.dart';

class FirstMainSliverToBox {
  /// Frequency 이미지 URL
  final String _frequencyImg =
      "https://i.ibb.co/QcVn97y/2021-12-16-1-33-11.png";

  final Color starbucksAccentColor = Color.fromARGB(255, 199, 176, 121);

  /// 추천 메뉴
  final List<Map<String, String>> recommendMenu = const [
    {
      "name": "돌체쿠키라떼",
      "imgUrl": "https://i.ibb.co/SwGPpzR/9200000003687-20211118142543832.jpg",
    },
    {
      "name": "아이스 홀리데이 돌체 쿠키 라떼",
      "imgUrl": "https://i.ibb.co/JHVXZ72/9200000003690-20211118142702357.jpg",
    },
    {
      "name": "스노우 민트 초콜릿",
      "imgUrl": "https://i.ibb.co/M91G17c/9200000003693-20211118142933650.jpg",
    },
    {
      "name": "아이스 스노우 민트 초콜릿",
      "imgUrl": "https://i.ibb.co/jyZK4C9/9200000003696-20211118143125337.jpg",
    },
    {
      "name": "스노우 민트 초콜릿 블렌디드",
      "imgUrl": "https://i.ibb.co/DKkV0rw/9200000003699-20211118143249044.jpg",
    },
  ];

  /// 크리스마스 이벤트 이미지 URL
  final String eventImg = "https://i.ibb.co/Fb0q43T/IMG-F9-BA5-CBCB476-1.jpg";

  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Frequency
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(_frequencyImg),
            ),
          ),

          SizedBox(
            height: 32,
          ),

          // 추천 메뉴 Title
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              // 공통스타일
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "이찬호",
                  style: TextStyle(color: starbucksAccentColor),
                ),
                TextSpan(text: "님을 위한 추천 메뉴"),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),

          // 추천메뉴
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 100,
              itemBuilder: (context, index) {
                final menu = recommendMenu[index % recommendMenu.length];
                final name = menu["name"] ?? "이름";
                final imageUrl = menu["imgUrl"] ?? "";
                return SizedBox(
                  width: 128,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 52,
                        //TIP: CircleAvata 배경에 맞춰서 동그랗게 이미지 넣는 방법
                        backgroundImage: NetworkImage(imageUrl),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(eventImg),
            ),
          ),
          SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
