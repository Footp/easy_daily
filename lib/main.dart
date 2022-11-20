// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      locale: const Locale('ko'),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    _c.pickDate.value = DateFormat('yyyy/MM/dd (E)', 'ko').format(
      DateTime.now(),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          width: 200,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  if (testMemo[_c.pickDate.value].runtimeType == Null) {
                    null;
                  } else {
                    _c.dailyMemo.value = testMemo[_c.pickDate];
                    allDayMemo[_c.pickDate] = testMemo[_c.pickDate];
                  }
                },
                child: const Text('테스트 메모 삽입'),
              ),
              TextButton(
                onPressed: () {
                  if (_c.dailyMemo.isNotEmpty) {
                    _c.dailyMemo.value = [];
                    allDayMemo.remove(_c.pickDate);
                  }
                },
                child: const Text('오늘의 메모 모두 삭제'),
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: const DailyPicker(),
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

class DailyPicker extends StatelessWidget {
  const DailyPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.navigate_before,
          color: Colors.black,
        ),
        Text(
          _c.pickDate.value,
          style: textStyle_basic,
        ),
        const Icon(
          Icons.navigate_next,
          color: Colors.black,
        ),
      ],
    );
  }
}
