// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'schedule.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Schedule {
  String user_id;
  String? parent_schedule_id;
  String name;
  DateTime starting_at;
  DateTime ending_at;
  bool is_success;
  DateTime created_at;
  Schedule({
    required this.user_id,
    required this.parent_schedule_id,
    required this.name,
    required this.starting_at,
    required this.ending_at,
    required this.is_success,
    required this.created_at,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
