// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            height: 50,
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
                  String _extraHour = _date.hour.toString();
                  _extraHour =
                      _extraHour.length != 2 ? '0$_extraHour' : _extraHour;
                  String _extraMinute = _date.minute.toString();
                  _extraMinute = _extraMinute.length != 2
                      ? '0$_extraMinute'
                      : _extraMinute;
                  String _extraTime = '$_extraHour:$_extraMinute';
                  Map<String, dynamic> creatMemo = {
                    'time': _extraTime,
                    'memo': value,
                    'categorie': '개인',
                  };
                  _c.dailyMemo.add(creatMemo);
                } else {
                  null;
                }
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}
