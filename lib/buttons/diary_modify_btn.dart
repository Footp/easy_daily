import 'package:flutter/material.dart';

class DiaryModifyBtn extends StatelessWidget {
  const DiaryModifyBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
      icon: const Icon(Icons.remove_red_eye),
    );
  }
}
