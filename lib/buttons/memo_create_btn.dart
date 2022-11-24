import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MemoCreateBtn extends StatelessWidget {
  const MemoCreateBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
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
              DateTime? _date = DateTime.now();
              String _extraTime = timeConvert(_date);
              Map<String, String> createMemo = {
                'time': _extraTime,
                'memo': value,
                'eMemo': '',
              };
              _c.dailyMemo.add(createMemo);
              Hive.box('EasyDaily_Memo').put(_c.pickDate.value, _c.dailyMemo);
            }
            _c.sendList.clear();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
