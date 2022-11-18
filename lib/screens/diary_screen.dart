import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/buttom_page_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: double.infinity,
              width: double.infinity,
              child: TextField(
                autofocus: true,
                enabled: true,
                maxLines: null,
                controller: TextEditingController(
                  text: _c.dailyDiary.value,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '작성된 일기가 없습니다.',
                ),
                style: const TextStyle(
                    fontSize: 20, color: Colors.black, height: 1.5),
                onChanged: ((value) {
                  _c.dailyDiary.value = value;
                }),
              ),
            ),
          ),
          const ButtomPageBar(),
        ],
      ),
    );
  }
}
