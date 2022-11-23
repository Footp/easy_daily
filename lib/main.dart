// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unrelated_type_equality_checks, avoid_print

import 'package:easy_daily/buttons/daily_picker_btn.dart';
import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/draw_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  FlutterNativeSplash.remove();
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
          drawer: const DrawScreen(),
          appBar: AppBar(
            backgroundColor:
                _c.pageCount == 0 ? Colors.blueAccent : Colors.pinkAccent,
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
