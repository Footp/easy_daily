import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ButtomPageBtn extends StatelessWidget {
  const ButtomPageBtn({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Obx(
      () => GestureDetector(
        onTap: () {
          nullDiaryCheck(c);
          c.pageCount.value = c.pageCount.value == 0 ? 1 : 0;
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: 50,
          width: double.infinity,
          color: Colors.grey,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.arrow_right),
                  ),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.keyboard_hide),
                  ),
                ],
              ),
              Center(
                child: Text(
                  buttomPageBar[c.pageCount.value],
                  style: textStyle_bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyPickerBtn extends StatelessWidget {
  const DailyPickerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              memoSelectExit(c, context);
              DateTime? pickDate = newDate!.add(const Duration(days: -1));
              dateTrans(c, pickDate);
              nullDiaryCheck(c);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () async {
              memoSelectExit(c, context);
              DateTime? pickDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), // 초깃값
                firstDate: DateTime(2022), // 시작일
                lastDate: DateTime.now(), // 마지막일
              );
              pickDate = pickDate.runtimeType == Null ? newDate : pickDate;
              dateTrans(c, pickDate);
              nullDiaryCheck(c);
            },
            onDoubleTap: () {
              memoSelectExit(c, context);
              DateTime? pickDate = DateTime.now();
              pickDate = pickDate.runtimeType == Null ? newDate : pickDate;
              dateTrans(c, pickDate);
              nullDiaryCheck(c);
            },
            child: Text(
              c.pickDate.value,
              style: textStyle_basic,
            ),
          ),
          IconButton(
            onPressed: () {
              memoSelectExit(c, context);
              DateTime? pickDate = newDate!.add(const Duration(days: 1));
              dateTrans(c, pickDate);
              nullDiaryCheck(c);
            },
            icon: const Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class EngPlusBtn extends StatelessWidget {
  const EngPlusBtn({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            alignment: Alignment.bottomCenter,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 340,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '원본',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: SelectableText(
                      c.dailyMemo[index]['memo'],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.black45, thickness: 1.0),
                  const SizedBox(height: 20),
                  const Text('영어', style: TextStyle(color: Colors.blue)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 3,
                    autofocus: true,
                    maxLength: 200,
                    enabled: true,
                    controller: TextEditingController(
                      text: c.dailyMemo[index]['eMemo'],
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(
                        10.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    style: textStyle_basic,
                    onChanged: (value) {
                      Map extraMemo = c.dailyMemo[index];
                      extraMemo['eMemo'] = value;
                      c.dailyMemo.removeAt(index);
                      c.dailyMemo.insert(index, extraMemo);
                      Hive.box('EasyDaily_Memo').put(
                        c.pickDate.value,
                        c.dailyMemo,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Text(
            'Eng+',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class MemoCopyBtn extends StatelessWidget {
  const MemoCopyBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        copyClip(context, index);
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Text(
            '복사',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }
}

class MemoCreateBtn extends StatelessWidget {
  const MemoCreateBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 70,
        width: size.width,
        child: TextField(
          autofocus: true,
          maxLength: 50,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: textStyle_basic,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              DateTime? date = DateTime.now();
              String extraTime = timeConvert(date);
              Map<String, String> createMemo = {
                'time': extraTime,
                'memo': value,
                'eMemo': '',
              };
              c.dailyMemo.add(createMemo);
              Hive.box('EasyDaily_Memo').put(c.pickDate.value, c.dailyMemo);
            }
            c.sendList.clear();
            Navigator.pop(context);
            scrollToMaxDown(c.scrollController.value, 300);
          },
        ),
      ),
    );
  }
}

class MemoDelBtn extends StatelessWidget {
  const MemoDelBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('메모를 삭제하시겠습니까?'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              c.dailyMemo.removeAt(index);
                              Hive.box('EasyDaily_Memo').put(
                                c.pickDate.value,
                                c.dailyMemo,
                              );
                              c.sendList.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('삭제'),
                          ),
                          const SizedBox(width: 50),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Text(
            '삭제',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }
}

class MemoSendBtn extends StatelessWidget {
  const MemoSendBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        nullDiaryCheck(c);
        c.sendList.sort();
        if (c.sendList.isEmpty) {
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
                      const Text('메모를 선택해 주세요.'),
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
        } else {
          {
            // 기존String데이터를 삭제하여 오류방지
            c.dailyDiary[0].runtimeType == String ? c.dailyDiary.clear() : null;
            c.dailyDiary[1].runtimeType == String ? c.dailyDiary.clear() : null;
          }
          {
            // 체크된 한글 다이어리 전송
            for (int i = 0; i < c.sendList.length; i++) {
              c.dailyDiary[0].add(
                c.dailyMemo[c.sendList[i]]['memo'],
              );
            }
          }
          {
            // 체크된 영어 다이어리 전송
            for (int i = 0; i < c.sendList.length; i++) {
              c.dailyMemo[c.sendList[i]]['eMemo'].length == 0
                  ? null
                  : c.dailyDiary[1].add(
                      c.dailyMemo[c.sendList[i]]['eMemo'],
                    );
            }
          }
          {
            // 첫번째 빈줄 삭제
            c.dailyDiary[0].length > 1 && c.dailyDiary[0].first.length == 0
                ? c.dailyDiary[0].removeAt(0)
                : null;

            c.dailyDiary[1].length > 1 && c.dailyDiary[1].first.length == 0
                ? c.dailyDiary[1].removeAt(0)
                : null;
          }
          // 모드 초기화 및 페이지 변경
          memoSelectExit(c, context);
          c.pageCount.value = 1;

          // 데이터베이스에 저장
          Hive.box('EasyDaily_Diary').put(c.pickDate.value, c.dailyDiary);
        }
      },
      child: Container(
        padding: EdgeInsets.zero,
        height: 50,
        width: double.infinity,
        color: Colors.lightBlue,
        child: Center(
          child: Text(
            'Send',
            style: textStyle_bold,
          ),
        ),
      ),
    );
  }
}

class MemoTimeBtn extends StatelessWidget {
  const MemoTimeBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            alignment: Alignment.bottomCenter,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 60,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  timeField(_c, context, 0, 2),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(_c, context, 3, 5),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(_c, context, 6, 8),
                ],
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Text(
            '시간',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }

  SizedBox timeField(Controller _c, BuildContext context, int a, int b) {
    return SizedBox(
      width: 30,
      child: Center(
        child: TextField(
          autofocus: true,
          maxLength: 2,
          textAlign: TextAlign.center,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          controller: TextEditingController(
            text: _c.dailyMemo[index]['time'].substring(a, b),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          style: textStyle_basic,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              value.length == 1 ? value = '0$value' : null;
              value = value.toString();
              Map extraMemoMap = _c.dailyMemo[index];
              extraMemoMap['time'] =
                  extraMemoMap['time'].replaceRange(a, b, value);
              _c.dailyMemo.removeAt(index);
              _c.dailyMemo.insert(index, extraMemoMap);
              _c.dailyMemo.sort((a, b) => a['time'].compareTo(b['time']));
              Hive.box('EasyDaily_Memo').put(_c.pickDate.value, _c.dailyMemo);
            } else {
              null;
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class DiaryPopupMenu extends StatelessWidget {
  const DiaryPopupMenu({
    Key? key,
    required this.c,
    required this.index,
  }) : super(key: key);

  final Controller c;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        diaryMoveCount = index;
        showDialog(
          context: context,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(bottom: 110.0),
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              insetPadding: EdgeInsets.zero,
              contentPadding: const EdgeInsets.all(10.0),
              content: SizedBox(
                height: 50,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: SizedBox(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('메모를 삭제하시겠습니까?'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              List extraDiary = c.dailyDiary[0];
                                              extraDiary.removeAt(index);
                                              c.dailyDiary[0] = extraDiary;
                                              Hive.box('EasyDaily_Diary').put(
                                                  c.pickDate.value,
                                                  c.dailyDiary);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('삭제'),
                                          ),
                                          const SizedBox(width: 50),
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('취소'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Text(
                            '삭제',
                            style: textStyle_iconbtn,
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black45,
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: c.dailyDiary[0][index]),
                        ).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('클립보드에 복사되었습니다.'),
                            ),
                          );
                        });
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Text(
                            '복사',
                            style: textStyle_iconbtn,
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black45,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (diaryMoveCount != 0) {
                          List extraList = c.dailyDiary[0];
                          extraList.insert(
                              diaryMoveCount - 1, extraList[diaryMoveCount]);
                          extraList.removeAt(diaryMoveCount + 1);
                          c.dailyDiary[0] = extraList;
                          diaryMoveCount--;
                        }
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(Icons.keyboard_arrow_up),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black45,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (diaryMoveCount != c.dailyDiary[0].length - 1) {
                          List extraList = c.dailyDiary[0];
                          extraList.insert(
                              diaryMoveCount + 2, extraList[diaryMoveCount]);
                          extraList.removeAt(diaryMoveCount);
                          c.dailyDiary[0] = extraList;
                          diaryMoveCount++;
                        }
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Row(
        children: const [
          SizedBox(
            height: 50,
            width: 30,
            child: Icon(
              Icons.more_vert,
              size: 20,
              color: Colors.black45,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class MemoPopupMenu extends StatelessWidget {
  const MemoPopupMenu({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(10.0),
      content: SizedBox(
        height: 50,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MemoTimeBtn(index: index),
            const VerticalDivider(
              color: Colors.black45,
            ),
            MemoDelBtn(index: index),
            const VerticalDivider(
              color: Colors.black45,
            ),
            MemoCopyBtn(index: index),
            const VerticalDivider(
              color: Colors.black45,
            ),
            EngPlusBtn(size: size, index: index),
          ],
        ),
      ),
    );
  }
}
