// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'package:easy_daily/buttons/btn_collection.dart';
import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DiaryBody extends StatelessWidget {
  const DiaryBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Scrollbar(
                        thickness: 6,
                        thumbVisibility: true,
                        controller: c.scrollController.value,
                        child: Container(
                          color: Colors.white,
                          height: double.infinity,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: ListView.builder(
                            controller: c.scrollController.value,
                            itemCount:
                                c.dailyDiary[c.diaryPageCount.value].length,
                            itemBuilder: (context, index) => Obx(
                              () => Container(
                                decoration: c.testEditMode == true
                                    ? const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey,
                                            width: 0.2,
                                          ),
                                        ),
                                      )
                                    : null,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DiaryPopupMenu(c: c, index: index),
                                    Obx(
                                      () => Expanded(
                                        child: c.testEditMode == false
                                            ? TextFieldMode(c, index, false)
                                            : TextFieldMode(c, index, true),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    c.testEditMode == true
                        ? GestureDetector(
                            onTap: () {
                              List extraDiary =
                                  c.dailyDiary[c.diaryPageCount.value];
                              extraDiary.add('');
                              c.dailyDiary[c.diaryPageCount.value] = extraDiary;
                              scrollToMaxDown(c.scrollController.value, 300);
                            },
                            child: Container(
                              color: Colors.white,
                              height: 60,
                              child: Center(
                                child: Text(
                                  diaryAddList[c.diaryPageCount.value],
                                  style: textStyle_behind,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          ButtomPageBtn(scaffoldKey: scaffoldKey),
        ],
      ),
    );
  }

  TextField TextFieldMode(Controller c, int index, bool isbool) {
    return TextField(
      autofocus: false,
      enabled: isbool,
      maxLines: null,
      controller: TextController(
        text: c.dailyDiary[c.diaryPageCount.value][index],
      ),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(top: 8),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        height: 2,
      ),
      onChanged: (String value) {
        c.dailyDiary[c.diaryPageCount.value][index] = value;
        Hive.box('EasyDaily_Diary').put(c.pickDate.value, c.dailyDiary);
      },
    );
  }
}

class TextController extends TextEditingController {
  TextController({required String text}) {
    this.text = text;
  }

  @override
  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}
