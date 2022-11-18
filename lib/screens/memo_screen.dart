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
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  _c.dailyMemo[index]['memo'],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                DateTime? _date = DateTime.now();
                                String _extraHour = _date.hour.toString();
                                _extraHour = _extraHour.length != 2
                                    ? '0$_extraHour'
                                    : _extraHour;
                                String _extraMinute = _date.minute.toString();
                                _extraMinute = _extraMinute.length != 2
                                    ? '0$_extraMinute'
                                    : _extraMinute;
                                String _extraTime = '$_extraHour:$_extraMinute';
                                Map<String, dynamic> creatMemo = {
                                  'time': _extraTime,
                                  'memo': value,
                                  'categorie': '개인',
                                };
                                _c.dailyMemo.add(creatMemo);
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
