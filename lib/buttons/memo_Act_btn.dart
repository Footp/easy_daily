// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, file_names, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MemoDelBtn extends StatelessWidget {
  const MemoDelBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      content: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('메모를 삭제하시겠습니까?'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _c.dailyMemo.removeAt(index);
                        Hive.box('EasyDaily_Memo').put(
                          _c.pickDate.value,
                          _c.dailyMemo.value,
                        );
                        print(_c.dailyMemo);
                        print(
                            Hive.box('EasyDaily_Memo').get(_c.pickDate.value));
                        Navigator.pop(context);
                      },
                      child: const Text('삭제'),
                    ),
                    const SizedBox(width: 30),
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
    );
  }
}

class EngPlusBtn extends StatelessWidget {
  const EngPlusBtn({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Text(
              '원본',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 2,
              autofocus: false,
              enabled: true,
              maxLength: 45,
              controller: TextEditingController(
                text: _c.dailyMemo[index]['memo'],
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              style: textStyle_basic,
              onChanged: (value) {
                Map _extraMemo = _c.dailyMemo[index];
                _extraMemo['memo'] = value;
                _c.dailyMemo.removeAt(index);
                _c.dailyMemo.insert(index, _extraMemo);
                Hive.box('EasyDaily_Memo').put(
                  _c.pickDate.value,
                  _c.dailyMemo.value,
                );
                print(_c.dailyMemo);
                print(
                  Hive.box('EasyDaily_Memo').get(
                    _c.pickDate.value,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.black45, thickness: 1.0),
            const SizedBox(height: 20),
            const Text('영어', style: TextStyle(color: Colors.blue)),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 3,
              autofocus: true,
              maxLength: 200,
              enabled: true,
              controller: TextEditingController(
                text: _c.dailyMemo[index]['eMemo'],
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(
                  10.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              style: textStyle_basic,
              onChanged: (value) {
                Map _extraMemo = _c.dailyMemo[index];
                _extraMemo['eMemo'] = value;
                _c.dailyMemo.removeAt(index);
                _c.dailyMemo.insert(index, _extraMemo);
                Hive.box('EasyDaily_Memo').put(
                  _c.pickDate.value,
                  _c.dailyMemo.value,
                );
                print(_c.dailyMemo);
                print(
                  Hive.box('EasyDaily_Memo').get(
                    _c.pickDate.value,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
