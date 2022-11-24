import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            alignment: Alignment.bottomCenter,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 340,
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
                  SizedBox(
                    height: 50,
                    child: SelectableText(
                      _c.dailyMemo[index]['memo'],
                      onTap: () => print(''),
                    ),
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(5),
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
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const SizedBox(
        width: 40,
        child: Center(
          child: Text(
            'Eng+',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
