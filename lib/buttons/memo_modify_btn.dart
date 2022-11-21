// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, avoid_print, invalid_use_of_protected_member

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MemoModifyBtn extends StatelessWidget {
  const MemoModifyBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 60,
        width: size.width,
        child: TextField(
          autofocus: true,
          maxLength: 45,
          controller: TextEditingController(
            text: _c.dailyMemo[index]['memo'],
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: textStyle_basic,
          onChanged: (value) {
            if (value.isNotEmpty) {
              // 리스트 안의 맵의 값이 변화해도 화면은 갱신되지 않는다.
              // 리스트 단위에서 맵을 통째로 교체하여 해결
              Map _extraMemo = _c.dailyMemo[index];
              _extraMemo['memo'] = value;
              _c.dailyMemo.removeAt(index);
              _c.dailyMemo.insert(index, _extraMemo);
              Hive.box('EasyDaily_Memo')
                  .put(_c.pickDate.value, _c.dailyMemo.value);
              print(_c.dailyDiary);
              print(Hive.box('EasyDaily_Memo').get(_c.pickDate.value));
            }
          },
          onSubmitted: (value) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
