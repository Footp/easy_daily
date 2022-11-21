// ignore_for_file: no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtomPageBtn extends StatelessWidget {
  const ButtomPageBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => GestureDetector(
        onTap: () {
          _c.pageCount.value = _c.pageCount.value == 0 ? 1 : 0;
          _c.pageViewCount.value = 0;
          _c.dailyDiary.isEmpty ? _c.dailyDiary.value = ['', ''] : null;
        },
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Container(
            height: double.infinity,
            width: size.width / 2,
            color: Colors.grey,
            child: Center(
              child: Text(
                buttomPageBar[_c.pageCount.value],
                style: textStyle_basic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
