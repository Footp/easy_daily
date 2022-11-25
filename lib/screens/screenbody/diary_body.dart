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
                            itemBuilder: (context, index) => Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 0.2,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DiaryPopupMenu(c: c, index: index),
                                  Expanded(
                                    child: TextField(
                                      autofocus: false,
                                      enabled: true,
                                      maxLines: null,
                                      controller: TextEditingController(
                                        text:
                                            c.dailyDiary[c.diaryPageCount.value]
                                                [index],
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
                                        c.dailyDiary[c.diaryPageCount.value]
                                            [index] = value;
                                        Hive.box('EasyDaily_Diary').put(
                                            c.pickDate.value, c.dailyDiary);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        List extraDiary = c.dailyDiary[c.diaryPageCount.value];
                        extraDiary.add('');
                        c.dailyDiary[c.diaryPageCount.value] = extraDiary;
                        scrollToMaxDown(c.scrollController.value, 300);
                      },
                      child: Container(
                        color: Colors.black12,
                        height: 60,
                        child: Center(
                          child: Text(
                            diaryAddList[c.diaryPageCount.value],
                            style: textStyle_behind,
                          ),
                        ),
                      ),
                    ),
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
}
