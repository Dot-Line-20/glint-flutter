// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as int,
      userId: json['userId'] as int,
      parentScheduleId: json['parentScheduleId'] as String?,
      name: json['name'] as String,
      startingAt: DateTime.parse(json['startingAt'] as String),
      endingAt: DateTime.parse(json['endingAt'] as String),
      isSuccess: json['isSuccess'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      categories: json['categories'] as List<dynamic>,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'parentScheduleId': instance.parentScheduleId,
      'name': instance.name,
      'startingAt': instance.startingAt.toIso8601String(),
      'endingAt': instance.endingAt.toIso8601String(),
      'isSuccess': instance.isSuccess,
      'createdAt': instance.createdAt.toIso8601String(),
      'categories': instance.categories,
    };
