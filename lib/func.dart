// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_print

import 'package:easy_daily/buttons/diary_modify_btn.dart';
import 'package:easy_daily/buttons/memo_send_btn.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

PageController pageController = PageController();
DateTime? newDate;

List buttomPageBar = [
  'Memo',
  'Diary',
];

List pageList = const [
  MemoScreen(),
  DiaryScreen(),
];

List pageActionList = const [
  MemoSendBtn(),
  DiaryModifyBtn(),
];

List sendMemoList = [];
List sendMemoListEng = [];

String timeConvert(input) {
  String _extra = DateFormat('HH:mm:ss').format(input);
  return _extra;
}

String dateConvert(DateTime input) {
  String _extra = DateFormat('yyyy/MM/dd (E)', 'ko').format(input);
  return _extra;
}

hiveDataGet(Controller _c) {
  Hive.box('EasyDaily_Memo').get(_c.pickDate.value) == null
      ? _c.dailyMemo.value = []
      : _c.dailyMemo.value = Hive.box('EasyDaily_Memo').get(_c.pickDate.value);
  Hive.box('EasyDaily_Diary').get(_c.pickDate.value) == null
      ? _c.dailyDiary.value = []
      : _c.dailyDiary.value =
          Hive.box('EasyDaily_Diary').get(_c.pickDate.value);
  print(Hive.box('EasyDaily_Memo').get(_c.pickDate.value));
  print(_c.dailyMemo);
}

dateTrans(Controller _c, DateTime? newDate) {
  _c.pickDate.value = DateFormat('yyyy/MM/dd (E)', 'ko').format(newDate!);
  hiveDataGet(_c);
}
