// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unrelated_type_equality_checks, avoid_print

import 'package:easy_daily/buttons/daily_picker_btn.dart';
import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:easy_daily/testdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/memo', page: () => const MemoScreen()),
        GetPage(name: '/diarykr', page: () => const DiaryPageKo()),
        GetPage(name: '/diaryen', page: () => const DiaryPageEn()),
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
    newDate = DateTime.now();
    dateTrans(_c, newDate);

    return SafeArea(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Hive.box('EasyDaily_Memo')
                        .put(_c.pickDate.value, testMemoList);
                    _c.dailyMemo.value = testMemoList;
                  },
                  child: const SizedBox(
                    width: 120,
                    child: Text('테스트 데이터 추가'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    Hive.box('EasyDaily_Memo').clear();
                    _c.dailyMemo.clear();
                    Hive.box('EasyDaily_Diary').clear();
                    _c.dailyDiary.clear();
                    Hive.openBox('EasyDaily_Memo');
                    Hive.openBox('EasyDaily_Diary');
                  },
                  child: const SizedBox(
                    width: 120,
                    child: Text('모든 데이터 삭제'),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const DailyPickerBtn(),
            actions: [
              pageActionList[_c.pageCount.value],
            ],
          ),
          body: pageList[_c.pageCount.value],
          floatingActionButton: _c.pageCount != 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.small(
                      hoverElevation: 0,
                      highlightElevation: 0,
                      elevation: 0,
                      onPressed: () {
                        _c.pageCount.value = _c.pageCount.value == 1 ? 2 : 1;
                        print(_c.pageCount);
                      },
                      child: _c.pageCount.value == 1
                          ? const Text('한')
                          : const Text('영'),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
