import 'package:easy_daily/buttons/diary_modify_btn.dart';
import 'package:easy_daily/buttons/memo_send_btn.dart';
import 'package:easy_daily/screens/diary_screen.dart';
import 'package:easy_daily/screens/memo_screen.dart';

List buttomPageBar = [
  'Memo',
  'Diary',
];

List pageList = const [
  MemoScreen(),
  DiaryScreen(),
];

List pageActionList = const [
  MemoSendBtn(),
  DiaryModifyBtn(),
];

List sendMemoList = [];

String timeConvert(input) {
  String a = input.hour.toString();
  a = a.length != 2 ? '0$a' : a;
  String b = input.minute.toString();
  b = b.length != 2 ? '0$b' : b;
  String c = input.second.toString();
  c = c.length != 2 ? '0$c' : c;
  String extra = '$a:$b:$c';
  return extra;
}

String dateConvert(input) {
  String a = input.year.toString();
  String b = input.month.toString();
  b = b.length != 2 ? '0$b' : b;
  String c = input.day.toString();
  c = c.length != 2 ? '0$c' : c;
  String extra = '$a/$b/$c';
  return extra;
}

List<Map<String, dynamic>> testMemoList = [
  {
    'date': '2022/11/18',
    'time': '08:30',
    'memo': '출출해서 집 앞 편의점에서 샌드위치 하나 구매',
  },
  {
    'date': '2022/11/18',
    'time': '08:50',
    'memo': '회사도착 샌드위치와 커피한잔의 여유',
  },
  {
    'date': '2022/11/18',
    'time': '09:00',
    'memo': '오전 업무시작 주간업무회의 준비 ',
  },
  {
    'date': '2022/11/18',
    'time': '10:00',
    'memo': '프로젝트 담당자 변경 프로젝트 조직도 수정작업',
  },
  {
    'date': '2022/11/18',
    'time': '12:00',
    'memo': '배가 안고파서 스벅에서 장군이와 커피마시며 수다타임',
  },
  {
    'date': '2022/11/18',
    'time': '13:00',
    'memo': '오후 업무시작',
  },
  {
    'date': '2022/11/18',
    'time': '14:00',
    'memo': '협력업체 이슈발생 대금지급 지연 문제로 계약파기 요청 김차장님에게 보고',
  },
  {
    'date': '2022/11/18',
    'time': '14:30',
    'memo': '대책회의 결과 50% 대금 지급으로 일단 진행하는것으로 협의필요',
  },
  {
    'date': '2022/11/18',
    'time': '17:30',
    'memo': '신규프로젝트 발생으로 담당자 지정 및 일정관련 회의',
  },
  {
    'date': '2022/11/18',
    'time': '18:00',
    'memo': '퇴근 오늘은 칼퇴',
  },
  {
    'date': '2022/11/18',
    'time': '19:00',
    'memo': '헬스장 도착 오늘은 하체날 달려보자',
  },
  {
    'date': '2022/11/18',
    'time': '21:00',
    'memo': '드디어 집 오늘 하체 잘 먹은듯 뿌듯하고 피곤하다',
  },
];
