import 'package:flutter/cupertino.dart';
import 'main.dart';

class BucketService extends ChangeNotifier {
  List<Bucket> buckets = [
    Bucket('잠자기', false),
  ]; // 버킷 리스트

  void createBucket(String job) {
    buckets.add(Bucket(job, false)); // 버킷 리스트에 추가
    notifyListeners(); // Consuer<BucketService>의 builder 부분만 새로고침
  }

  void updateBucket(Bucket bucket, int index) {
    buckets[index] = bucket; // 버킷 리스트 수정
    notifyListeners(); // Consuer<BucketService>의 builder 부분만 새로고침
  }

  void deleteBucket(int index) {
    buckets.removeAt(index); // 버킷 리스트 삭제
    notifyListeners(); // Consuer<BucketService>의 builder 부분만 새로고침
  }
}
