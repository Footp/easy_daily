// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyPickerBtn extends StatelessWidget {
  const DailyPickerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.navigate_before,
          color: Colors.black,
        ),
        Text(
          _c.pickDate.value,
          style: textStyle_basic,
        ),
        const Icon(
          Icons.navigate_next,
          color: Colors.black,
        ),
      ],
    );
  }
}
