// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names

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
        } else if (_c.dailyDiaryKo.isNotEmpty) {
          SendCoverDialog(context, _c);
        } else {
          SendDiary(_c);
          _c.pageCount.value = 1;
        }
      },
      icon: const Icon(Icons.send_rounded),
    );
  }

  void SendDiary(Controller _c) {
    {
      for (int i = 0; i < _c.dailyMemo.length; i++) {
        sendMemoList.add(
          _c.dailyMemo[i]['memo'],
        );
      }
      _c.dailyDiaryKo.value = sendMemoList.join('\n\n');
      sendMemoList.clear();
    }
    {
      for (int i = 0; i < _c.dailyMemo.length; i++) {
        _c.dailyMemo[i]['eMemo'].length == 0
            ? null
            : sendMemoListEng.add(
                _c.dailyMemo[i]['eMemo'],
              );
      }
      _c.dailyDiaryEng.value = sendMemoListEng.join('\n\n');
      sendMemoListEng.clear();
    }
  }

  void SendCoverDialog(BuildContext context, Controller _c) {
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
                            SendDiary(_c);
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
  }
}
