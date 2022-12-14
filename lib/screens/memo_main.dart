import 'package:easy_daily/buttons/btn_collection.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screenbody/draw_screen.dart';
import 'package:easy_daily/screenbody/memo_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: const DrawScreen(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const DailyPickerBtn(),
        leading: Obx(
          () => c.selectMode.value == false
              ? IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.question_mark,
                    size: 20,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    if (c.dailyMemo.length == c.sendList.length) {
                      c.sendList.clear();
                    } else {
                      c.sendList.clear();
                      for (int i = 0; i < c.dailyMemo.length; i++) {
                        c.sendList.add(i);
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.done_all,
                  ),
                ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                c.selectMode.value = c.selectMode.value == false ? true : false;
                c.sendList.clear();
                FocusScope.of(context).unfocus();
              },
              icon: c.selectMode.value == false
                  ? const Icon(Icons.send_rounded)
                  : const Icon(Icons.close),
            ),
          ),
        ],
      ),
      body: MemoBody(scaffoldKey: scaffoldKey),
    );
  }
}
