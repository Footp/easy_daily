// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoCopyBtn extends StatelessWidget {
  const MemoCopyBtn({
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
        copyClip(context, index);
      },
      child: SizedBox(
        width: 40,
        child: Center(
          child: Text(
            'Copy',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }
}
