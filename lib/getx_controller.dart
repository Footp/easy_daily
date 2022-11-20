import 'package:get/get.dart';

class Controller extends GetxController {
  // 데이터 관련
  RxList dailyMemo = [].obs;
  RxString dailyDiary = ''.obs;

  // 날짜 임시저장
  RxString pickDate = '날짜를 선택하세요.'.obs;

  // 페이지 관련
  RxInt pageCount = 0.obs;
}
