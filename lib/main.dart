// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:easy_daily/buttons/daily_picker_btn.dart';
import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
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

// Hive 저장소에서 불러오기
Future initialization(BuildContext? context) async {
  await Hive.initFlutter();
  await Hive.openBox('EasyDaily_Memo');
  await Hive.openBox('EasyDaily_Diary');
  await Future.delayed(
    const Duration(seconds: 3),
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

    HiveDataGet(_c);
    return SafeArea(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const Drawer(
            width: 200,
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
          body: pageList[_c.pageCount.value],
          floatingActionButton: _c.pageCount != 0
              ? Obx(
                  () => Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 0, 0, 16.0),
                    child: Align(
                      alignment: _c.pageViewCount == 0
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: FloatingActionButton.small(
                        hoverElevation: 0,
                        highlightElevation: 0,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        onPressed: () {
                          _c.pageViewCount.value =
                              _c.pageViewCount == 0 ? 1 : 0;
                          pageController.animateToPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                              _c.pageViewCount.value);
                        },
                        child: _c.pageViewCount == 0
                            ? const Icon(Icons.navigate_next)
                            : const Icon(Icons.navigate_before),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  void HiveDataGet(Controller _c) {
    Hive.box('EasyDaily_Memo').get('Memo') != Null
        ? null
        : _c.dailyMemo.value =
            Hive.box('EasyDaily_Memo').get(_c.pickDate.value);
    Hive.box('EasyDaily_Diary').get('Diary') != Null
        ? null
        : _c.dailyDiary.value =
            Hive.box('EasyDaily_Diary').get(_c.pickDate.value);
  }
}
