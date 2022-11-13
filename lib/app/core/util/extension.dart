extension FormatString on DateTime {
  String get format {
    return "$month월 $day일";
  }

  String get format2 {
    // 오전 / 오후
    String ampm = hour > 12 ? "오후" : "오전";

    // 12시간제
    int hour12 = hour > 12 ? hour - 12 : hour;
    return "$ampm $hour12시 $minute분";
  }
}
