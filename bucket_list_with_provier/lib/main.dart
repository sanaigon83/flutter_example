import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http; // http 패키지 추가

import 'bucket_service.dart';

void main() {
  runApp(
    // MultiProvider를 사용하여 여러개의 Provider를 등록할 수 있습니다.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BucketService()),
      ],
      child: const MyApp(),
    ),
  );
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

/// 버킷 클래스
class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Consumer를 사용하여 BucketService를 가져옵니다.
    return Consumer<BucketService>(builder: (context, bucketService, child) {
      List<Bucket> bucketList = bucketService.buckets;
      return Scaffold(
        appBar: AppBar(
          title: Text("버킷 리스트"),
        ),
        body: bucketList.isEmpty
            ? Center(child: Text("버킷 리스트를 작성해 주세요."))
            : ListView.builder(
                itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
                itemBuilder: (context, index) {
                  var bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                  return ListTile(
                    // 버킷 리스트 할 일
                    title: Text(
                      bucket.job,
                      style: TextStyle(
                        fontSize: 24,
                        color: bucket.isDone ? Colors.grey : Colors.black,
                        decoration: bucket.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    // 삭제 아이콘 버튼
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.delete),
                      onPressed: () {
                        bucketService.deleteBucket(index);
                      },
                    ),
                    onTap: () {
                      bucket.isDone = !bucket.isDone; // 완료 여부 변경
                      bucketService.updateBucket(bucket, index);
                    },
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            // localhost:8080에 접근해서 /open-ai/question을 호출한다.
            // 이때, POST 방식으로 데이터를 전송한다.
            // 데이터는 {"question": "질문 내용"} 형식으로 전송한다.
            var client = http.Client();
            try {
              var response = await client.post(
                Uri(
                    scheme: "http",
                    host: "localhost",
                    port: 8080,
                    path: "/open-ai/question"),
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(
                  {
                    'system':
                        '질문이 들어오면 다음의 ""안에 들어가는 형식에 맞는 대답을 구분해서 알려줘 "장소정보, 주차장, 주차요금, 식당정보"',
                    'user': '에버랜드에 대해서 알려줘'
                  },
                ),
              );

              var decodedRes = jsonDecode(utf8.decode(response.bodyBytes));
              print(decodedRes);
            } finally {
              client.close();
            }

            /*
            // + 버튼 클릭시 버킷 생성 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreatePage()),
            );
            */
          },
        ),
      );
    });
  }
}

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용합니다.
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      error = "내용을 입력해주세요."; // 내용이 없는 경우 에러 메세지
                    });
                  } else {
                    setState(() {
                      error = null; // 내용이 있는 경우 에러 메세지 숨기기
                    });

                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job); // 버킷 리스트에 추가
                    Navigator.pop(context); // 화면을 종료합니다.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
