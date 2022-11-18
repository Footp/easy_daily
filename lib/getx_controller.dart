import 'package:get/get.dart';

class Controller extends GetxController {
  RxList dailyMemo = [].obs;
  RxString dailyDiaryString = ''.obs;

  //날짜 임시저장
  RxString selectDay = '날짜를 선택하세요.'.obs;

  //페이지 관련
  RxInt pageCount = 0.obs;

  RxList memoList = [].obs;
}
