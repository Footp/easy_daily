// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MemoCreateBtn extends StatelessWidget {
  const MemoCreateBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 60,
            width: size.width,
            child: TextField(
              autofocus: true,
              maxLength: 45,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: textStyle_basic,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  DateTime? _date = DateTime.now();
                  String _extraTime = timeConvert(_date);
                  String _extraDate = dateConvert(_date);
                  Map<String, String> createMemo = {
                    'time': _extraTime,
                    'memo': value,
                  };

                  allDayMemo[_c.pickDate.value] != Null
                      ? allDayMemo[_c.pickDate] = []
                      : null;
                  allDayMemo[_c.pickDate].add(createMemo);
                  _c.dailyMemo.add(createMemo);
                } else {
                  null;
                }
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      child: Obx(
        () => Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.red,
          child: _c.dailyMemo.isNotEmpty
              ? null
              : Center(
                  child: Text(
                    '화면을 탭하여 메모를 작성하세요.',
                    style: textStyle_behind,
                  ),
                ),
        ),
      ),
    );
  }
}
