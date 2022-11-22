// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_print, invalid_use_of_protected_member

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MemoTimeBtn extends StatelessWidget {
  const MemoTimeBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
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
                  timeField(_c, context, 0, 2),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(_c, context, 3, 5),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(_c, context, 6, 8),
                ],
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        width: 40,
        child: Center(
          child: Text(
            'Time',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }

  SizedBox timeField(Controller _c, BuildContext context, int a, int b) {
    return SizedBox(
      width: 30,
      child: Center(
        child: TextField(
          autofocus: true,
          maxLength: 2,
          textAlign: TextAlign.center,
          controller: TextEditingController(
            text: _c.dailyMemo[index]['time'].substring(a, b),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          style: textStyle_basic,
          onSubmitted: (value) {
            value.length == 1 ? value = '0$value' : null;
            value = value.toString();
            Map _extraMemoMap = _c.dailyMemo.value[index];
            _extraMemoMap['time'] =
                _extraMemoMap['time'].replaceRange(a, b, value);
            _c.dailyMemo.removeAt(index);
            _c.dailyMemo.insert(index, _extraMemoMap);
            _c.dailyMemo.sort((a, b) => a['time'].compareTo(b['time']));
            Hive.box('EasyDaily_Memo')
                .put(_c.pickDate.value, _c.dailyMemo.value);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
