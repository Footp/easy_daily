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

//- 날짜 관련 -//

// 시간 포맷 변경
String timeConvert(input) {
  String _extra = DateFormat('HH:mm:ss').format(input);
  return _extra;
}

// 날짜 포맷 변경
String dateConvert(DateTime input) {
  String _extra = DateFormat('yyyy/MM/dd (E)', 'ko').format(input);
  return _extra;
}

// 메모, 다이어리 불러오기
hiveDataGet(Controller _c) {
  Hive.box('EasyDaily_Memo').get(_c.pickDate.value) == null
      ? _c.dailyMemo.value = []
      : _c.dailyMemo.value = Hive.box('EasyDaily_Memo').get(_c.pickDate.value);
  Hive.box('EasyDaily_Diary').get(_c.pickDate.value) == null
      ? _c.dailyDiary.value = []
      : _c.dailyDiary.value =
          Hive.box('EasyDaily_Diary').get(_c.pickDate.value);
}

dateTrans(Controller _c, DateTime? newDate) {
  _c.pickDate.value = DateFormat('yyyy/MM/dd (E)', 'ko').format(newDate!);
  hiveDataGet(_c);
}

// 메모 수정
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

//- 메모 복사 관련 -//

String clipBoardString = '';

// 시간+메모 합집합
selectText(index) {
  final _c = Get.put(Controller());
  String _extraTime = _c.dailyMemo[index]['time'].substring(0, 5);
  String _extraMemo = _c.dailyMemo[index]['memo'];
  List _extraList = [_extraTime, _extraMemo];
  return clipBoardString = _extraList.join(' ');
}

// 메모 클립보드로 복사
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

//- 샘플이미지 --//

String examplePath = 'assets/example/';

List exampleImageList = [
  'assets/example/1.png',
  'assets/example/2.png',
  'assets/example/3.png',
  'assets/example/4.png',
  'assets/example/5.png',
  'assets/example/6.png',
  'assets/example/7.png',
  'assets/example/8.png',
  'assets/example/9.png',
  'assets/example/10.png',
  'assets/example/11.png',
  'assets/example/12.png',
  'assets/example/13.png',
  'assets/example/14.png',
  'assets/example/15.png',
];

//- 다이어리 전송 관련 -//

// 체크된 다이어리 전송
sendDiary(Controller _c) {
  _c.dailyDiary.isEmpty
      ? _c.dailyDiary.value = [
          [''],
          ['']
        ]
      : null;
  _c.dailyDiary[0].runtimeType == String ? _c.dailyDiary.clear() : null;
  _c.dailyDiary[1].runtimeType == String ? _c.dailyDiary.clear() : null;
  {
    for (int i = 0; i < _c.dailyMemo.length; i++) {
      _c.dailyDiary[0].add(
        _c.dailyMemo[i]['memo'],
      );
    }
  }
  {
    for (int i = 0; i < _c.dailyMemo.length; i++) {
      _c.dailyMemo[i]['eMemo'].length == 0
          ? null
          : _c.dailyDiary[1].add(
              _c.dailyMemo[i]['eMemo'],
            );
    }
  }
  Hive.box('EasyDaily_Diary').put(_c.pickDate.value, _c.dailyDiary.value);
}

// 메모 없을시 알림창
noMemo(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('전송할 메모가 없습니다.'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('확인'),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
