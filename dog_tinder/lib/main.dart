import 'dart:core';
import 'package:dog_tinder/ehternet.dart';
import 'package:flutter/material.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:photo_card_swiper/photo_card_swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ethernet(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ExamplePhotoWidget extends StatefulWidget {
  List<PhotoCard> _photos = [
    PhotoCard(
        title: "Title 1",
        description: "Description 1",
        imagePath:
            "https://upload.wikimedia.org/wikipedia/commons/4/43/Cute_dog.jpg",
        isLocalImage: false,
        cardId: "1"),
    PhotoCard(
        title: "Title 2",
        description: "Description 2",
        imagePath:
            "https://images.pexels.com/photos/895259/pexels-photo-895259.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        isLocalImage: false,
        cardId: "2"),
    PhotoCard(
        title: "Title 3",
        description: "Description 3",
        imagePath:
            "https://images.pexels.com/photos/3361739/pexels-photo-3361739.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        isLocalImage: false,
        cardId: "3"),
    PhotoCard(
        title: "Title 4",
        description: "Description 4",
        imagePath:
            "https://images.pexels.com/photos/4588435/pexels-photo-4588435.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        isLocalImage: false,
        cardId: "4"),
    PhotoCard(
        title: "Title 5",
        description: "Description 5",
        imagePath:
            "https://images.pexels.com/photos/3090875/pexels-photo-3090875.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        isLocalImage: false,
        cardId: "5"),
  ];

  @override
  State<ExamplePhotoWidget> createState() => _ExamplePhotoWidgetState();
}

class _ExamplePhotoWidgetState extends State<ExamplePhotoWidget> {
  // 이거를 왜 해줘야 하는거지??
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // 가로로 꽉 채우기
          children: [
            DiscoverAppBarWidget(),
            // call photoCardSwiper widget
            Expanded(
              child: Stack(
                children: [
                  NoMoreDataWidget(),
                  PhotoCardSwiper(
                    photos: widget._photos,
                    cardSwiped: _cardSwiped,
                    showLoading: true,
                    hideCenterButton: false,
                    hideTitleText: false,
                    hideDescriptionText: false,
                    imageScaleType: BoxFit.cover,
                    imageBackgroundColor: Colors.grey,
                    leftButtonIcon: Icons.close,
                    rightButtonIcon: Icons.thumb_up,
                    centerButtonIcon: Icons.favorite,
                    leftButtonBackgroundColor: Colors.red[100],
                    leftButtonIconColor: Colors.red[600],
                    rightButtonBackgroundColor: Colors.lightBlue[100],
                    rightButtonIconColor: Colors.lightBlue[600],
                    centerButtonBackgroundColor: Colors.lightGreen[100],
                    centerButtonIconColor: Colors.lightGreen[600],
                    leftButtonAction: _leftButtonCliecked,
                    centerButtonAction: _centerButtonClicked,
                    rightButtonAction: _rightButtonClicked,
                    onCardTap: _onCardTap,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _cardSwiped(CardActionDirection _direction, int _index) {
    print("Card swiped $_direction at index $_index");

    int _lastIndex = widget._photos.length - 1;
    if (_index == _lastIndex) {
      _loadMorePhotos(_lastIndex);
    }
  }

  _leftButtonCliecked() {
    print("Left button clicked");
  }

  _centerButtonClicked() {
    print("Center button clicked");
  }

  _rightButtonClicked() {
    print("Right button clicked");
  }

  _onCardTap() {
    print("Card tapped");
  }

  void _loadMorePhotos(int _lastIndex) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        widget._photos = List.generate(2, (index) {
          int _cardId = _lastIndex + index + 1;
          return PhotoCard(
              title: "Title $_cardId",
              description: "Description $_cardId",
              imagePath:
                  "https://images.pexels.com/photos/4588435/pexels-photo-4588435.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              isLocalImage: false,
              cardId: _cardId.toString());
        });
      });
    });
  }
}

class NoMoreDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            Icon(
              Icons.error,
              size: 60,
              color: Colors.grey,
            ),
            Text(
              "No more data found",
              style: TextStyle(fontSize: 17, color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverAppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 20, bottom: 10),
      child: Text(
        "내 취향저격 겸댕이",
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w900, color: Colors.grey[500]),
      ),
    );
  }
}
