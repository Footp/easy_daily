import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_main.dart';
import 'package:easy_daily/screens/memo_main.dart';
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
];

List mainPageList = const [
  MemoScreen(),
  DiaryScreen(),
];

//- 날짜 관련 -//

// 시간 포맷 변경
String timeConvert(input) {
  String extra = DateFormat('HH:mm:ss').format(input);
  return extra;
}

// 날짜 포맷 변경
String dateConvert(DateTime input) {
  String extra = DateFormat('yyyy/MM/dd (E)', 'ko').format(input);
  return extra;
}

// 메모, 다이어리 불러오기
hiveDataGet(Controller c) {
  Hive.box('EasyDaily_Memo').get(c.pickDate.value) == null
      ? c.dailyMemo.value = []
      : c.dailyMemo.value = Hive.box('EasyDaily_Memo').get(c.pickDate.value);
  Hive.box('EasyDaily_Diary').get(c.pickDate.value) == null
      ? c.dailyDiary.value = []
      : c.dailyDiary.value = Hive.box('EasyDaily_Diary').get(c.pickDate.value);
}

dateTrans(Controller c, DateTime? date) {
  newDate = date;
  c.pickDate.value = DateFormat('yyyy/MM/dd (E)', 'ko').format(newDate!);
  hiveDataGet(c);
}

// 메모 수정
modifyDialog(context, c, index, size, String memoIndex) {
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
            text: c.dailyMemo[index][memoIndex],
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: textStyle_basic,
          onChanged: (value) {
            if (value.isNotEmpty) {
              // 리스트 안의 맵의 값이 변화해도 화면은 갱신되지 않는다.
              // 리스트 단위에서 맵을 통째로 교체하여 해결
              Map extraMemo = c.dailyMemo[index];
              extraMemo[memoIndex] = value;
              c.dailyMemo.removeAt(index);
              c.dailyMemo.insert(index, extraMemo);
              Hive.box('EasyDaily_Memo')
                  .put(c.pickDate.value, c.dailyMemo.value);
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

diaryModifyDialog(context, c, index, size) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 110.0),
      child: AlertDialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          height: 20,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  List extraDiary = c.dailyDiary[0];
                  extraDiary.removeAt(index);
                  c.dailyDiary[0] = extraDiary;
                  Hive.box('EasyDaily_Diary')
                      .put(c.pickDate.value, c.dailyDiary);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: 40,
                  child: Text(
                    'Del',
                    style: textStyle_iconbtn,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black45,
              ),
              const Text('diary'),
              const VerticalDivider(
                color: Colors.black45,
              ),
              const Text('diary'),
              const VerticalDivider(
                color: Colors.black45,
              ),
              const Text('diary'),
              const VerticalDivider(
                color: Colors.black45,
              ),
              const Text('diary'),
            ],
          ),
        ),
      ),
    ),
  );
}

//- 메모 복사 관련 -//

String clipBoardString = '';

// 시간+메모 합집합
selectText(index) {
  final c = Get.put(Controller());
  String extraTime = c.dailyMemo[index]['time'].substring(0, 5);
  String extraMemo = c.dailyMemo[index]['memo'];
  List extraList = [extraTime, extraMemo];
  return clipBoardString = extraList.join(' ');
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

nullDiaryCheck(Controller c) {
  c.dailyDiary.isEmpty
      ? c.dailyDiary.value = [
          [''],
          ['']
        ]
      : null;
}

memoSelectExit(Controller c, BuildContext context) {
  c.selectMode.value = false;
  c.sendList.clear();
  FocusScope.of(context).unfocus();
}

int diaryMoveCount = 0;

scrollToMaxDown(c, int millisec) {
  Future.delayed(
    const Duration(milliseconds: 100),
    () => c.animateTo(c.position.maxScrollExtent,
        duration: Duration(milliseconds: millisec), curve: Curves.linear),
  );
}

List memoAddList = [
  '이곳을 탭하면 새 메모를 작성할 수 있습니다.',
  'Click this Space to create a new memo.',
];

List diaryAddList = [
  '이곳을 탭하면 줄이 추가됩니다.',
  'Click this Space to add a text line.',
];
