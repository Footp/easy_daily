import 'package:get/get.dart';

class Controller extends GetxController {
  // 데이터 관련
  RxList dailyMemo = [].obs;
  RxList dailyDiary = [].obs;

  // 날짜 임시저장
  RxString pickDate = ''.obs;

  // 페이지 관련
  RxInt pageCount = 0.obs;
  RxInt pageViewCount = 0.obs;
}
