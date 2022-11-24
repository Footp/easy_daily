import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoSendBtn extends StatelessWidget {
  const MemoSendBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _c.sendList.sort();
        if (_c.sendList.isEmpty) {
          noMemo(context);
        } else
          sendDiary(_c);
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
                            sendDiary(_c);
                            Navigator.pop(context);
                            _c.pageCount.value = 1;
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
