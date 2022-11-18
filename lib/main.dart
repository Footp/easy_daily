import 'package:easy_daily/func.dart';
import 'package:easy_daily/screens/buttom_page_bar.dart';
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
    Size size = MediaQuery.of(context).size;

    print(_c.pageCount.value);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: Center(
              child: Text(
                '2022/11/18 (금)',
                style: textStyle_basic,
              ),
            ),
          ),
        ),
        body: Obx(
          () => pageList[_c.pageCount.value],
        ),
      ),
    );
  }
}
