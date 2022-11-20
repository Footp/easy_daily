// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

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
        } else if (_c.dailyDiary.isNotEmpty) {
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
                      const Text('기존 일기가 덮어씌워집니다.'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
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
                                  _c.dailyDiary.value =
                                      sendMemoList.join('\n\n');
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
          _c.dailyDiary.value = sendMemoList.join('\n\n');
          sendMemoList.clear();
          _c.pageCount.value = 1;
        }
      },
      icon: const Icon(Icons.send_rounded),
    );
  }
}
