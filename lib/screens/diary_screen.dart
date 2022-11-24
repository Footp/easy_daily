import 'package:easy_daily/getx_controller.dart';
import 'package:easy_daily/buttons/buttom_page_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DiaryPageKo extends StatelessWidget {
  const DiaryPageKo({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _c = Get.put(Controller());
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Obx(
            () => Expanded(
              child: GestureDetector(
                onTap: () {
                  if (_c.dailyDiary[0].last.length != 0) {
                    List _extraDiary = _c.dailyDiary[0];
                    _extraDiary.add('');
                    _c.dailyDiary[0] = _extraDiary;
                  }
                },
                child: Container(
                  // color: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: _c.dailyDiary[0].length,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            List _extraDiary = _c.dailyDiary[0];
                            _extraDiary.removeAt(index);
                            _c.dailyDiary[0] = _extraDiary;
                            Hive.box('EasyDaily_Diary')
                                .put(_c.pickDate.value, _c.dailyDiary);
                          },
                          child: Row(
                            children: const [
                              SizedBox(
                                height: 30,
                                width: 20,
                                child: Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: Colors.black12,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: TextField(
                              autofocus: _c.dailyDiary[0][index].length == 0
                                  ? true
                                  : false,
                              enabled: true,
                              maxLines: null,
                              controller: TextEditingController(
                                text: _c.dailyDiary[0][index],
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                height: 1.5,
                              ),
                              onChanged: (value) {
                                _c.dailyDiary[0][index] = value;
                                Hive.box('EasyDaily_Diary')
                                    .put(_c.pickDate.value, _c.dailyDiary);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const ButtomPageBtn(),
        ],
      ),
    );
  }
}

class DiaryPageEn extends StatelessWidget {
  const DiaryPageEn({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _c = Get.put(Controller());
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              height: double.infinity,
              width: double.infinity,
              child: ListView.builder(
                itemCount: _c.dailyDiary[1].length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(
                            height: 30,
                            width: 20,
                            child: Icon(
                              Icons.more_vert,
                              size: 20,
                              color: Colors.black26,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          enabled: true,
                          maxLines: null,
                          controller: TextEditingController(
                            text: _c.dailyDiary[1][index],
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            height: 1.5,
                          ),
                          onChanged: (value) {
                            _c.dailyDiary[1][index] = value;
                            Hive.box('EasyDaily_Diary')
                                .put(_c.pickDate.value, _c.dailyDiary);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const ButtomPageBtn(),
        ],
      ),
    );
  }
}
