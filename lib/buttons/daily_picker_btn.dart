// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyPickerBtn extends StatelessWidget {
  const DailyPickerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              newDate = newDate!.add(const Duration(days: -1));
              dateTrans(_c, newDate);
            },
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () async {
              newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), // 초깃값
                firstDate: DateTime(2022), // 시작일
                lastDate: DateTime.now(), // 마지막일
              );
              dateTrans(_c, newDate);
            },
            child: Text(
              _c.pickDate.value,
              style: textStyle_basic,
            ),
          ),
          IconButton(
            onPressed: () {
              newDate = newDate!.add(const Duration(days: 1));
              dateTrans(_c, newDate);
            },
            icon: const Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
