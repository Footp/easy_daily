// ignore_for_file: no_leading_underscores_for_local_identifiers, duplicate_ignore, unused_local_variable

import 'package:easy_daily/buttons/memo_Act_btn.dart';
import 'package:easy_daily/buttons/memo_create_btn.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/buttons/buttom_page_btn.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_daily/buttons/memo_modify_btn.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    height: _c.dailyMemo.isEmpty
                        ? 0
                        : _c.dailyMemo.length * 50 > size.height - 150
                            ? size.height - 150
                            : _c.dailyMemo.length * 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: _c.dailyMemo.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                _c.dailyMemo[index]['time'].substring(0, 5),
                                style: textStyle_behind,
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                // 메모 수정
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      MemoModifyBtn(index: index),
                                ),
                                onLongPress: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      EngPlusBtn(size: size, index: index),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    _c.dailyMemo[index]['memo'],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 메모 입력
                  const Expanded(
                    child: MemoCreateBtn(),
                  ),
                ],
              ),
            ),
          ),
          const ButtomPageBtn(),
        ],
      ),
    );
  }
}
