// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:easy_daily/func.dart';
import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoActBtn extends StatelessWidget {
  const MemoActBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () {
              MemoDelDialog(context, _c);
            },
            child: Text(
              '-',
              style: textStyle_basic,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              EngPlusDialog(context, size, _c);
            },
            child: const Text('Eng+'),
          ),
        ],
      ),
    );
  }

  void EngPlusDialog(BuildContext context, Size size, Controller _c) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          height: 300,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '원본',
                style: TextStyle(color: Colors.blue),
              ),
              TextField(
                maxLines: 3,
                autofocus: false,
                enabled: true,
                controller: TextEditingController(
                  text: _c.dailyMemo[index]['memo'],
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: textStyle_basic,
                onChanged: (value) {
                  Map _extraMemo = _c.dailyMemo[index];
                  _extraMemo['memo'] = value;
                  _c.dailyMemo.removeAt(index);
                  _c.dailyMemo.insert(index, _extraMemo);
                  allDayMemo[_c.pickDate] = _c.dailyMemo.value;
                  print(_c.dailyMemo[index]['memo']);
                  print(allDayMemo[_c.pickDate][index]['memo']);
                  print(allDayMemo[_c.pickDate].runtimeType);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(color: Colors.black45, thickness: 1.0),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '영어',
                style: TextStyle(color: Colors.blue),
              ),
              TextField(
                maxLines: 3,
                autofocus: true,
                maxLength: 200,
                enabled: true,
                controller: TextEditingController(
                  text: _c.dailyMemo[index]['eMemo'],
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: textStyle_basic,
                onChanged: (value) {
                  Map _extraMemo = _c.dailyMemo[index];
                  _extraMemo['eMemo'] = value;
                  _c.dailyMemo.removeAt(index);
                  _c.dailyMemo.insert(index, _extraMemo);
                  allDayMemo[_c.pickDate] = _c.dailyMemo.value;
                  print(_c.dailyMemo[index]['eMemo']);
                  print(allDayMemo[_c.pickDate][index]['eMemo']);
                  print(allDayMemo[_c.pickDate].runtimeType);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void MemoDelDialog(BuildContext context, Controller _c) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('메모를 삭제하시겠습니까?'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          _c.dailyMemo.removeAt(index);
                          allDayMemo[_c.pickDate] = _c.dailyMemo.value;
                          print(_c.dailyMemo.length);
                          print(allDayMemo[_c.pickDate].length);
                          print(allDayMemo[_c.pickDate].runtimeType);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('삭제'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('취소'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
