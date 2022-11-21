// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names, avoid_print, invalid_use_of_protected_member

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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
    _c.dailyDiary.isEmpty ? _c.dailyDiary.value = ['', ''] : null;
    {
      for (int i = 0; i < _c.dailyMemo.length; i++) {
        sendMemoList.add(
          _c.dailyMemo[i]['memo'],
        );
      }
      _c.dailyDiary[0] = sendMemoList.join('\n\n');
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
      _c.dailyDiary[1] = sendMemoListEng.join('\n\n');
      Hive.box('EasyDaily_Diary').put(_c.pickDate.value, _c.dailyDiary.value);
      sendMemoListEng.clear();
    }
    print(_c.dailyDiary);
    print(Hive.box('EasyDaily_Diary').get(_c.pickDate.value));
  }

  void SendCoverDialog(BuildContext context, Controller _c) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('일기를 덮어쓰겠습니까?'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            SendDiary(_c);
                            Navigator.pop(context);
                            _c.pageCount.value = 1;
                            print(_c.dailyDiary);
                            print(Hive.box('EasyDaily_Diary')
                                .get(_c.pickDate.value));
                          },
                          child: const Text('확인')),
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
  }
}
