// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, invalid_use_of_protected_member, file_names

import 'package:easy_daily/func.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          content: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('서비스 사용 예제입니다.'),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: ListView.builder(
                      itemCount: exampleImageList.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          const Divider(
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            exampleImageList[index],
                            height: 500,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Row(
        children: const [
          Text(
            '서비스 사용 예제',
            style: TextStyle(color: Colors.blueAccent),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.link,
            size: 20,
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
