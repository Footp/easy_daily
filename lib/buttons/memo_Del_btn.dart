// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MemoDelBtn extends StatelessWidget {
  const MemoDelBtn({
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
            content: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('메모를 삭제하시겠습니까?'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              _c.dailyMemo.removeAt(index);
                              Hive.box('EasyDaily_Memo').put(
                                _c.pickDate.value,
                                _c.dailyMemo.value,
                              );
                              print(_c.dailyMemo);
                              print(Hive.box('EasyDaily_Memo')
                                  .get(_c.pickDate.value));
                              Navigator.pop(context);
                            },
                            child: const Text('삭제'),
                          ),
                          const SizedBox(width: 50),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        width: 40,
        child: Center(
          child: Text(
            'Del',
            style: textStyle_iconbtn,
          ),
        ),
      ),
    );
  }
}
