// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_daily/buttons/btn_collection.dart';
import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoBody extends StatelessWidget {
  const MemoBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => Container(
                width: double.infinity,
                color:
                    c.selectMode.value == false ? Colors.white : Colors.black26,
                child: Column(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        thickness: 6,
                        thumbVisibility: true,
                        controller: c.scrollController.value,
                        child: ListView.builder(
                          controller: c.scrollController.value,
                          itemCount: c.dailyMemo.length,
                          itemBuilder: (context, index) => Obx(
                            () => GestureDetector(
                              onTap: () {
                                c.selectMode.value == false
                                    ? modifyDialog(context, c, index, size,
                                        c.memoPageCount == 0 ? 'memo' : 'eMemo')
                                    : {
                                        c.sendList.contains(index) == false
                                            ? c.sendList.add(index)
                                            : c.sendList.remove(index)
                                      };
                              },
                              onLongPress: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => Padding(
                                  padding: const EdgeInsets.only(bottom: 110.0),
                                  child:
                                      MemoPopupMenu(size: size, index: index),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: c.sendList.contains(index) == false
                                      ? c.selectMode.value == false
                                          ? Colors.white
                                          : Colors.transparent
                                      : Colors.white,
                                  border: const Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.2,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(left: 8.0),
                                height: 60,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: c.sendList.contains(index) == false
                                          ? Text(
                                              c.dailyMemo[index]['time']
                                                  .substring(0, 5),
                                              style: textStyle_behind,
                                            )
                                          : const Icon(Icons.check_circle),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: c.memoPageCount == 0
                                            ? Text(
                                                c.dailyMemo[index]['memo'],
                                              )
                                            : c.dailyMemo[index]['eMemo']
                                                        .length ==
                                                    0
                                                ? Text(
                                                    c.dailyMemo[index]['memo'],
                                                    style: textStyle_behind,
                                                  )
                                                : Text(
                                                    c.dailyMemo[index]['eMemo'],
                                                    style: textStyle_basic,
                                                  ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Container(
                                      height: double.infinity,
                                      width: 16.0,
                                      color:
                                          c.dailyMemo[index]['eMemo'].length ==
                                                  0
                                              ? Colors.transparent
                                              : Colors.redAccent,
                                      child:
                                          c.dailyMemo[index]['eMemo'].length ==
                                                  0
                                              ? null
                                              : const Center(
                                                  child: Text(
                                                    'E',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        c.selectMode.value == false
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const MemoCreateBtn(),
                              )
                            : null;
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 80,
                        child: Center(
                          child: c.selectMode == false
                              ? Text(
                                  memoAddList[c.memoPageCount.value],
                                  style: textStyle_behind,
                                )
                              : Text(
                                  c.sendList.isEmpty
                                      ? '전송할 메모를 선택해주세요.'
                                      : c.dailyMemo.length != c.sendList.length
                                          ? '${c.dailyMemo.length}개 중 ${c.sendList.length}개의 메모가 선택되었습니다.'
                                          : '모든 메모가 선택되었습니다.',
                                  style: textStyle_basic,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => c.selectMode.value == false
                ? ButtomPageBtn(scaffoldKey: scaffoldKey)
                : const MemoSendBtn(),
          )
        ],
      ),
    );
  }
}
