import 'package:easy_daily/buttons/btn_collection.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/screenbody/diary_body.dart';
import 'package:easy_daily/screens/screenbody/draw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            // onPressed: () => scaffoldKey.currentState?.openDrawer(),
            onPressed: () =>
                c.diaryPageCount.value = c.diaryPageCount.value == 0 ? 1 : 0,
            child: Text(
              c.diaryPageCount.value == 0 ? '한' : 'E',
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              String extraString = c.dailyDiary[0].join('\n');
              Clipboard.setData(
                ClipboardData(text: extraString),
              ).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('클립보드에 복사되었습니다.'),
                  ),
                );
              });
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
      body: DiaryBody(scaffoldKey: scaffoldKey),
    );
  }
}
