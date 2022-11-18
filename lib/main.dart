// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_daily/func.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/memo', page: () => const MemoScreen()),
        GetPage(name: '/diary', page: () => const DiaryScreen()),
      ],
      title: 'Easy Daily',
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const Drawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: Center(
              child: Text(
                '2022/11/18 (금)',
                style: textStyle_basic,
              ),
            ),
            actions: [
              Obx(
                () => pageActionList[_c.pageCount.value],
              ),
            ],
          ),
        ),
        body: Obx(
          () => pageList[_c.pageCount.value],
        ),
      ),
    );
  }
}
