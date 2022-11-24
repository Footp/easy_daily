import 'package:easy_daily/buttons/eng_plus_btn.dart';
import 'package:easy_daily/buttons/memo_Del_btn.dart';
import 'package:easy_daily/buttons/memo_copy_btn.dart';
import 'package:easy_daily/buttons/memo_create_btn.dart';
import 'package:easy_daily/buttons/memo_send_btn.dart';
import 'package:easy_daily/buttons/memo_time_btn.dart';
// ignore: unused_import
import 'package:easy_daily/func.dart';
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
              () => GestureDetector(
                onTap: () => _c.selectMode == false
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const MemoCreateBtn(),
                      )
                    : null,
                child: Container(
                  width: double.infinity,
                  color: _c.selectMode == false ? Colors.white : Colors.black26,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _c.dailyMemo.length,
                          itemBuilder: (context, index) => Obx(
                            () => GestureDetector(
                              // 메모 수정
                              onTap: () {
                                _c.selectMode == false
                                    ? modifyDialog(context, _c, index, size)
                                    : {
                                        _c.sendList.contains(index) == false
                                            ? _c.sendList.add(index)
                                            : _c.sendList.remove(index)
                                      };
                              },

                              onLongPress: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => Padding(
                                  padding: const EdgeInsets.only(bottom: 110.0),
                                  child: AlertDialog(
                                    alignment: Alignment.bottomCenter,
                                    insetPadding: EdgeInsets.zero,
                                    content: SizedBox(
                                      height: 20,
                                      width: 300,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MemoTimeBtn(index: index),
                                          const VerticalDivider(
                                            color: Colors.black45,
                                          ),
                                          MemoModifyBtn(index: index),
                                          const VerticalDivider(
                                            color: Colors.black45,
                                          ),
                                          EngPlusBtn(size: size, index: index),
                                          const VerticalDivider(
                                            color: Colors.black45,
                                          ),
                                          MemoDelBtn(index: index),
                                          const VerticalDivider(
                                            color: Colors.black45,
                                          ),
                                          MemoCopyBtn(index: index),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                color: _c.sendList.contains(index) == false
                                    ? _c.selectMode == false
                                        ? Colors.white
                                        : Colors.transparent
                                    : Colors.white,
                                padding: const EdgeInsets.only(left: 16.0),
                                height: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        _c.dailyMemo[index]['time']
                                            .substring(0, 5),
                                        style: textStyle_behind,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          _c.dailyMemo[index]['memo'],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 16.0,
                                      color:
                                          _c.dailyMemo[index]['eMemo'].length ==
                                                  0
                                              ? Colors.transparent
                                              : Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => _c.selectMode == false ? ButtomPageBtn() : MemoSendBtn())
        ],
      ),
    );
  }
}
