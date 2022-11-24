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
    // ignore: no_leading_underscores_for_local_identifiers
    final _c = Get.put(Controller());
    // ignore: unused_local_variable
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
                                _c.dailyMemo,
                              );
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
