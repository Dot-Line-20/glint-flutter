// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      user_id: json['user_id'] as String,
      post_id: json['post_id'] as String?,
      comment_id: json['comment_id'] as String?,
      reason: json['reason'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'post_id': instance.post_id,
      'comment_id': instance.comment_id,
      'reason': instance.reason,
      'created_at': instance.created_at.toIso8601String(),
    };
