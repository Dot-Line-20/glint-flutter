// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      user_id: json['user_id'] as String,
      parent_schedule_id: json['parent_schedule_id'] as String?,
      name: json['name'] as String,
      starting_at: DateTime.parse(json['starting_at'] as String),
      ending_at: DateTime.parse(json['ending_at'] as String),
      is_success: json['is_success'] as bool,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'parent_schedule_id': instance.parent_schedule_id,
      'name': instance.name,
      'starting_at': instance.starting_at.toIso8601String(),
      'ending_at': instance.ending_at.toIso8601String(),
      'is_success': instance.is_success,
      'created_at': instance.created_at.toIso8601String(),
    };
