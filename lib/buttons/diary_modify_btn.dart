// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryModifyBtn extends StatelessWidget {
  const DiaryModifyBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return IconButton(
      onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
      icon: const Icon(Icons.save),
      // onPressed: () {
      //   diaryIconList.length != _c.diaryIconCount.value + 1
      //       ? _c.diaryIconCount++
      //       : _c.diaryIconCount.value = 0;
      // },
      // icon: diaryIconList[_c.diaryIconCount.value],
    );
  }
}
