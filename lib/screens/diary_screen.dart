// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_const_constructors

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/buttons/buttom_page_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              children: const [
                DiaryPageKo(),
                DiaryPageEn(),
              ],
            ),
          ),
          const ButtomPageBtn(),
        ],
      ),
    );
  }
}

class DiaryPageKo extends StatelessWidget {
  const DiaryPageKo({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      height: double.infinity,
      width: double.infinity,
      child: TextField(
        autofocus: true,
        enabled: true,
        maxLines: null,
        controller: TextEditingController(
          text: _c.dailyDiaryKo.value,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '작성된 일기가 없습니다.',
        ),
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          height: 1.5,
        ),
        onChanged: ((value) {
          _c.dailyDiaryKo.value = value;
        }),
      ),
    );
  }
}

class DiaryPageEn extends StatelessWidget {
  const DiaryPageEn({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      height: double.infinity,
      width: double.infinity,
      child: TextField(
        autofocus: true,
        enabled: true,
        maxLines: null,
        controller: TextEditingController(
          text: _c.dailyDiaryEng.value,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'No diaries were created.',
        ),
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          height: 1.5,
        ),
        onChanged: ((value) {
          _c.dailyDiaryEng.value = value;
          print(_c.dailyDiaryEng);
        }),
      ),
    );
  }
}
