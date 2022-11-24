import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        modifyDialog(context, _c, index, size);
      },
      child: SizedBox(
        width: 40,
        child: Center(
          child: Text(
            'Modify',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }
}
