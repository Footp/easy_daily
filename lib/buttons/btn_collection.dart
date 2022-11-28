// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

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
                  Center(
                    child: TextButton(
                      onPressed: () => c.languageCount.value =
                          c.languageCount.value == 0 ? 1 : 0,
                      child: Text(
                        c.languageCount.value == 0 ? '한' : 'E',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  c.pageCount.value == 1
                      ? Center(
                          child: IconButton(
                            onPressed: () {
                              String extraString = c
                                  .dailyDiary[c.languageCount.value]
                                  .join('\n');
                              Clipboard.setData(
                                ClipboardData(text: extraString),
                              ).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('클립보드에 복사되었습니다.'),
                                  ),
                                );
                              });
                            },
                            icon: const Icon(
                              Icons.copy,
                              size: 20,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              Center(
                child: c.pageCount.value == 0
                    ? Text(
                        memoPageBar[c.languageCount.value],
                        style: const TextStyle(
                            fontFamily: 'Nanum_Myeongjo',
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      )
                    : Text(
                        diaryPageBar[c.languageCount.value],
                        style: const TextStyle(
                            fontFamily: 'Nanum_Myeongjo',
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
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
                      // 번역API 사용 고려중
                      // onTap: () => showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     content: SizedBox(
                      //       child: Text('test'),
                      //     ),
                      //   ),
                      // ),
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
      child: const SizedBox(
        height: 60,
        width: 60,
        child: Center(
            child: Icon(
          Icons.copy,
          size: 24,
        )),
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
          enabled: true,
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
            scrollToMaxDown(c.scrollController.value);
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
      child: const SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Icon(
            Icons.delete_outline,
            size: 24,
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
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        MemoToDiaryKr(c, context, size),
        MemoToDiaryEn(c, context, size),
      ],
    );
  }

  GestureDetector MemoToDiaryKr(Controller c, BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        nullDiaryCheck(c);
        c.sendList.sort();
        if (c.sendList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('선택한 메모가 없습니다.'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          {
            // 체크된 한글 다이어리 전송
            for (int i = 0; i < c.sendList.length; i++) {
              c.dailyDiary[0].add(
                c.dailyMemo[c.sendList[i]]['memo'],
              );
            }
          }
          {
            // 첫번째 빈줄 삭제
            c.dailyDiary[0].length > 1 && c.dailyDiary[0].first.length == 0
                ? c.dailyDiary[0].removeAt(0)
                : null;
          }
          // 데이터베이스에 저장
          Hive.box('EasyDaily_Diary').put(c.pickDate.value, c.dailyDiary);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('한글메모가 전송되었습니다.'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                  label: '이동하기',
                  onPressed: () {
                    c.pageCount.value = 1;
                    c.languageCount.value = 0;
                    c.selectMode.value = false;
                    c.sendList.clear();
                  }),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.zero,
        height: 50,
        width: size.width / 2,
        color: Colors.lightBlue,
        child: Center(
          child: Text(
            '한글메모 전송하기',
            style: textStyle_bold,
          ),
        ),
      ),
    );
  }

  GestureDetector MemoToDiaryEn(Controller c, BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        nullDiaryCheck(c);
        c.sendList.sort();
        if (c.sendList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('선택한 메모가 없습니다.'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
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
            c.dailyDiary[1].length > 1 && c.dailyDiary[1].first.length == 0
                ? c.dailyDiary[1].removeAt(0)
                : null;
          }
          // 데이터베이스에 저장
          Hive.box('EasyDaily_Diary').put(c.pickDate.value, c.dailyDiary);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('영어메모가 전송되었습니다.'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                  label: '이동하기',
                  onPressed: () {
                    c.pageCount.value = 1;
                    c.languageCount.value = 1;
                    c.selectMode.value = false;
                    c.sendList.clear();
                  }),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.zero,
        height: 50,
        width: size.width / 2,
        color: Colors.redAccent,
        child: Center(
          child: Text(
            '영어메모 전송하기',
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
    final c = Get.put(Controller());
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
                  timeField(c, context, 0, 2),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(c, context, 3, 5),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(c, context, 6, 8),
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
          child: Icon(
            Icons.timer_outlined,
            size: 24,
          ),
        ),
      ),
    );
  }

  SizedBox timeField(Controller c, BuildContext context, int a, int b) {
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
            text: c.dailyMemo[index]['time'].substring(a, b),
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
              Map extraMemoMap = c.dailyMemo[index];
              extraMemoMap['time'] =
                  extraMemoMap['time'].replaceRange(a, b, value);
              c.dailyMemo.removeAt(index);
              c.dailyMemo.insert(index, extraMemoMap);
              c.dailyMemo.sort((a, b) => a['time'].compareTo(b['time']));
              Hive.box('EasyDaily_Memo').put(c.pickDate.value, c.dailyMemo);
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
    return c.textEditMode == true
        ? GestureDetector(
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
                          DiaryDel(context),
                          const VerticalDivider(
                            color: Colors.black45,
                          ),
                          DiaryCopy(context),
                          const VerticalDivider(
                            color: Colors.black45,
                          ),
                          DiaryMoveUp(),
                          const VerticalDivider(
                            color: Colors.black45,
                          ),
                          DiaryMoveDown(),
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
          )
        : const SizedBox(
            height: 50,
            width: 40,
          );
  }

  GestureDetector DiaryCopy(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(
          ClipboardData(text: c.dailyDiary[c.languageCount.value][index]),
        ).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('클립보드에 복사되었습니다.'),
            ),
          );
        });
        Navigator.pop(context);
      },
      child: const SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Icon(
            Icons.copy,
            size: 24,
          ),
        ),
      ),
    );
  }

  GestureDetector DiaryDel(BuildContext context) {
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
                    const Text('이 줄을 삭제하시겠습니까?'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              List extraDiary =
                                  c.dailyDiary[c.languageCount.value];
                              extraDiary.removeAt(index);
                              c.dailyDiary[c.languageCount.value] = extraDiary;
                              Hive.box('EasyDaily_Diary')
                                  .put(c.pickDate.value, c.dailyDiary);
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
      child: const SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: Icon(
            Icons.delete_outlined,
            size: 24,
          ),
        ),
      ),
    );
  }

  GestureDetector DiaryMoveDown() {
    return GestureDetector(
      onTap: () {
        if (diaryMoveCount != c.dailyDiary[c.languageCount.value].length - 1) {
          List extraList = c.dailyDiary[c.languageCount.value];
          extraList.insert(diaryMoveCount + 2, extraList[diaryMoveCount]);
          extraList.removeAt(diaryMoveCount);
          c.dailyDiary[c.languageCount.value] = extraList;
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
    );
  }

  GestureDetector DiaryMoveUp() {
    return GestureDetector(
      onTap: () {
        if (diaryMoveCount != 0) {
          List extraList = c.dailyDiary[c.languageCount.value];
          extraList.insert(diaryMoveCount - 1, extraList[diaryMoveCount]);
          extraList.removeAt(diaryMoveCount + 1);
          c.dailyDiary[c.languageCount.value] = extraList;
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
