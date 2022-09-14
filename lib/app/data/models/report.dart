// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'report.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Report {
  String user_id;
  String? post_id;
  String? comment_id;
  String reason;
  DateTime created_at;
  Report({
    required this.user_id,
    required this.post_id,
    required this.comment_id,
    required this.reason,
    required this.created_at,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
