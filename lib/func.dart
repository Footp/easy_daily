// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_daily/buttons/diary_modify_btn.dart';
import 'package:easy_daily/buttons/memo_send_btn.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

PageController pageController = PageController();

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
