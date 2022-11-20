// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:easy_daily/buttons/daily_picker_btn.dart';
import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
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

    DataGet(_c);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(
                height: 20,
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
            title: const DailyPickerBtn(),
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

  void DataGet(Controller _c) {
    allDayMemo[_c.pickDate] == null
        ? null
        : _c.dailyMemo.value = allDayMemo[_c.pickDate];

    allDayDiary[_c.pickDate] == null
        ? null
        : _c.dailyDiary.value = allDayDiary[_c.pickDate];
  }
}
