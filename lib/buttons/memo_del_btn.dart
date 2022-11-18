// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoDelBtn extends StatelessWidget {
  const MemoDelBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return SizedBox(
      height: 30,
      child: Align(
        alignment: Alignment.centerRight,
        child: OutlinedButton(
          onPressed: () {
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
                        const Text('메모를 삭제하시겠습니까?'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _c.dailyMemo.removeAt(index);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('삭제'),
                              ),
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
          child: Text(
            '-',
            style: textStyle_basic,
          ),
        ),
      ),
    );
  }
}
