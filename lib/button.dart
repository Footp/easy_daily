import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoSendBtn extends StatelessWidget {
  const MemoSendBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return IconButton(
      onPressed: () {
        if (_c.dailyMemo.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('전송할 메모가 없습니다.'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
        } else if (_c.dailyDiary.value.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('기존 일기를 덮어쓰시겠습니까?'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  for (int i = 0;
                                      i < _c.dailyMemo.length;
                                      i++) {
                                    sendMemoList.add(
                                      _c.dailyMemo[i]['memo'],
                                    );
                                  }
                                  _c.dailyDiary.value = sendMemoList.join('\n');
                                  sendMemoList.clear();
                                  Navigator.pop(context);
                                  _c.pageCount.value = 1;
                                },
                                child: const Text('확인')),
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
        } else {
          for (int i = 0; i < _c.dailyMemo.length; i++) {
            sendMemoList.add(
              _c.dailyMemo[i]['memo'],
            );
          }
          _c.dailyDiary.value = sendMemoList.join('\n');
          sendMemoList.clear();
          _c.pageCount.value = 1;
        }
        ;
      },
      icon: const Icon(Icons.send_rounded),
    );
  }
}

class DiaryModifyBtn extends StatelessWidget {
  const DiaryModifyBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return IconButton(
      onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
      icon: const Icon(Icons.save),
      // onPressed: () {
      //   diaryIconList.length != _c.diaryIconCount.value + 1
      //       ? _c.diaryIconCount++
      //       : _c.diaryIconCount.value = 0;
      // },
      // icon: diaryIconList[_c.diaryIconCount.value],
    );
  }
}
