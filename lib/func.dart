// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:easy_daily/buttons/diary_modify_btn.dart';
import 'package:easy_daily/buttons/memo_send_btn.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

DateTime? newDate;

List buttomPageBar = [
  'Memo',
  'Diary',
  'Diary',
];

List pageList = const [
  MemoScreen(),
  DiaryPageKo(),
  DiaryPageEn(),
];

List pageActionList = const [
  MemoSendBtn(),
  DiaryModifyBtn(),
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

modifyDialog(context, _c, index, size) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 70,
        width: size.width,
        child: TextField(
          autofocus: true,
          maxLength: 50,
          controller: TextEditingController(
            text: _c.dailyMemo[index]['memo'],
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: textStyle_basic,
          onChanged: (value) {
            if (value.isNotEmpty) {
              // 리스트 안의 맵의 값이 변화해도 화면은 갱신되지 않는다.
              // 리스트 단위에서 맵을 통째로 교체하여 해결
              Map _extraMemo = _c.dailyMemo[index];
              _extraMemo['memo'] = value;
              _c.dailyMemo.removeAt(index);
              _c.dailyMemo.insert(index, _extraMemo);
              Hive.box('EasyDaily_Memo')
                  .put(_c.pickDate.value, _c.dailyMemo.value);
              print(_c.dailyDiary);
              print(Hive.box('EasyDaily_Memo').get(_c.pickDate.value));
            }
          },
          onSubmitted: (value) {
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}

String clipBoardString = '';

selectText(index) {
  final _c = Get.put(Controller());
  String _extraTime = _c.dailyMemo[index]['time'].substring(0, 5);
  String _extraMemo = _c.dailyMemo[index]['memo'];
  List _extraList = [_extraTime, _extraMemo];
  return clipBoardString = _extraList.join(' ');
}

copyClip(context, index) {
  Clipboard.setData(
    ClipboardData(text: selectText(index)),
  ).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('클립보드에 복사되었습니다.'),
      ),
    );
  });
}
