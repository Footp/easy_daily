import 'package:easy_daily/button.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:flutter/material.dart';

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

// List diaryIconList = const [
//   Icon(Icons.minor_crash_outlined),
//   Icon(Icons.abc),
//   Icon(Icons.add_card),
//   Icon(Icons.dashboard),
// ];

List sendMemoList = [];
