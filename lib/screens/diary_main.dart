import 'package:easy_daily/buttons/btn_collection.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screenbody/diary_body.dart';
import 'package:easy_daily/screenbody/draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: const DrawScreen(),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const DailyPickerBtn(),
        leading: Obx(
          () => TextButton(
            onPressed: () =>
                c.diaryPageCount.value = c.diaryPageCount.value == 0 ? 1 : 0,
            child: Text(
              c.diaryPageCount.value == 0 ? '한' : 'E',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                c.testEditMode.value =
                    c.testEditMode.value == false ? true : false;
              },
              icon: c.testEditMode.value == false
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.edit_note),
            ),
          ),
        ],
      ),
      body: DiaryBody(scaffoldKey: scaffoldKey),
    );
  }
}
