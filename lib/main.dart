import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
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
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> memoList = [
      {'time': '08:30', 'memo': '출근완료'},
      {'time': '09:00', 'memo': '업무시작'},
      {'time': '09:30', 'memo': '업무회의'},
      {'time': '11:30', 'memo': '거래처 ㅇㅇ협의통화, 수정요청 전달하고 일정 조정하여 김차장님에게 보고완료'},
    ];

    return Scaffold(
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
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: memoList.isEmpty
                      ? 0
                      : memoList.length * 50 > size.height - 150
                          ? size.height - 150
                          : memoList.length * 50,
                  width: double.infinity,
                  color: Colors.amber,
                  child: ListView.builder(
                    itemCount: memoList.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(
                              memoList[index]['time'],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                memoList[index]['memo'],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
