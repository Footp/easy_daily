import 'package:easy_daily/screenbody/example.dart';
import 'package:easy_daily/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawScreen extends StatelessWidget {
  const DrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '쉬운일기',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '하루를 쉽게 기록하고',
              style: TextStyle(fontSize: 12),
            ),
            const Text(
              '영어일기를 쉽게 씁니다.',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 30),
            const Text('사용설명'),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text('빈공간'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.touch_app,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('  싱글탭 - 새메모 작성'),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Text('메모'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.touch_app,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('  싱글탭 - 메모 수정'),
                    const SizedBox(height: 10),
                    const Text('  롱탭 - 추가기능 로드'),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Text('전송버튼'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.send_rounded,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('  다이어리로 메모전송'),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Text('뷰버튼'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.remove_red_eye,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('  다이어리 읽기모드로 전환'),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Text('플로팅버튼'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.circle,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('  한/영 다이어리 전환'),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('하단바'),
                    const SizedBox(height: 10),
                    const Text('  메모/다이어리 전환'),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Eng+'),
                    const SizedBox(height: 10),
                    const Text('  영어일기 작성기능'),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ExampleScreen(),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    const Text('문의 및 의견보내기'),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          const ClipboardData(
                            text: 'darn_think@icloud.com',
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: Text(
                              '이메일주소가 클립보드에\n복사되었습니다.',
                              style: textStyle_basic,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'darn_think@icloud.com',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '© 2022 Team 다른생각',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
