import 'package:easy_daily/func.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';

class MemoCopyBtn extends StatelessWidget {
  const MemoCopyBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
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
