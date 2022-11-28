import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var scrollController = ScrollController().obs;

  // 데이터 관련
  RxList dailyMemo = [].obs;
  RxList dailyDiary = [].obs;
  RxList sendList = [].obs;

  // 날짜 임시저장
  RxString pickDate = ''.obs;

  // 페이지 관련
  RxInt pageCount = 0.obs;
  RxInt languageCount = 0.obs;

  // 다이어리 체크박스
  RxBool checkKr = false.obs;
  RxBool checkEn = false.obs;

  // 모드변경 관련
  RxBool selectMode = false.obs;
  RxBool textEditMode = false.obs;

  // History
  RxList memoUndoHistory = [].obs;
  RxList diaryUndoHistory = [[], []].obs;
}
