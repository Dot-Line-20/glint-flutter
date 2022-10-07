// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'schedule.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Schedule {
  int id;
  int userId;
  String? parentScheduleId;
  String name;
  DateTime startingAt;
  DateTime endingAt;
  bool isSuccess;
  DateTime createdAt;
  List<dynamic> categories;
  Schedule({
    required this.id,
    required this.userId,
    required this.parentScheduleId,
    required this.name,
    required this.startingAt,
    required this.endingAt,
    required this.isSuccess,
    required this.createdAt,
    required this.categories,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
