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
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.question_mark,
            size: 20,
          ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                c.textEditMode.value =
                    c.textEditMode.value == false ? true : false;
              },
              icon: c.textEditMode.value == false
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
