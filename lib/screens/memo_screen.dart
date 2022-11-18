// ignore_for_file: no_leading_underscores_for_local_identifiers, duplicate_ignore, unused_local_variable

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/screens/buttom_page_bar.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoScreen extends StatelessWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: _c.dailyMemo.isEmpty
                        ? 0
                        : _c.dailyMemo.length * 50 > size.height - 150
                            ? size.height - 150
                            : _c.dailyMemo.length * 50,
                    width: double.infinity,
                    color: Colors.amber,
                    child: ListView.builder(
                      itemCount: _c.dailyMemo.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                _c.dailyMemo[index]['time'],
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                // 메모 수정
                                onLongPress: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    alignment: Alignment.bottomCenter,
                                    insetPadding: EdgeInsets.zero,
                                    content: SizedBox(
                                      width: size.width,
                                      child: TextField(
                                        autofocus: true,
                                        maxLength: 45,
                                        controller: TextEditingController(
                                          text: _c.dailyMemo[index]['memo'],
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        style: textStyle_basic,
                                        onSubmitted: (value) {
                                          if (value.isEmpty) {
                                            null;
                                          } else {
                                            // 리스트 안의 맵의 값이 변화해도 화면은 갱신되지 않는다.
                                            // 리스트 단위에서 맵을 통째로 교체하여 해결
                                            Map _extraMemo =
                                                _c.dailyMemo[index];
                                            _extraMemo['memo'] = value;
                                            _c.dailyMemo.removeAt(index);
                                            _c.dailyMemo
                                                .insert(index, _extraMemo);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    _c.dailyMemo[index]['memo'],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 메모 입력
                  Expanded(
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          alignment: Alignment.bottomCenter,
                          insetPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: size.width,
                            child: TextField(
                              autofocus: true,
                              maxLength: 45,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: textStyle_basic,
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  DateTime? _date = DateTime.now();
                                  String _extraHour = _date.hour.toString();
                                  _extraHour = _extraHour.length != 2
                                      ? '0$_extraHour'
                                      : _extraHour;
                                  String _extraMinute = _date.minute.toString();
                                  _extraMinute = _extraMinute.length != 2
                                      ? '0$_extraMinute'
                                      : _extraMinute;
                                  String _extraTime =
                                      '$_extraHour:$_extraMinute';
                                  Map<String, dynamic> creatMemo = {
                                    'time': _extraTime,
                                    'memo': value,
                                    'categorie': '개인',
                                  };
                                  _c.dailyMemo.add(creatMemo);
                                } else {
                                  null;
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ButtomPageBar(),
        ],
      ),
    );
  }
}
