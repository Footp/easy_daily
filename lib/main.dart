import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx_controller.dart';

void main() {
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Daily',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: Center(
              child: Text(
                '2022/11/18 (금)',
                style: textStyle_basic,
              ),
            ),
          ),
        ),
        body: Obx(
          () => Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: _c.memoList.isEmpty
                      ? 0
                      : _c.memoList.length * 50 > size.height - 150
                          ? size.height - 150
                          : _c.memoList.length * 50,
                  width: double.infinity,
                  color: Colors.amber,
                  child: ListView.builder(
                    itemCount: _c.memoList.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              _c.memoList[index]['time'],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                _c.memoList[index]['memo'],
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
                            onSubmitted: (value) {
                              DateTime? _date = DateTime.now();
                              String _extraTime =
                                  '${_date.hour.toString()}:${_date.minute.toString()}';

                              Map<String, dynamic> creatMemo = {
                                'time': _extraTime,
                                'memo': value,
                                'categorie': '개인',
                              };
                              _c.memoList.add(creatMemo);
                              print(_extraTime);
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
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: size.width / 2,
                        color: Colors.grey,
                        child: const Center(child: Text('Memo')),
                      ),
                      Container(
                        height: double.infinity,
                        width: size.width / 2,
                        color: Colors.amberAccent,
                        child: const Center(child: Text('Diary')),
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
