// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as int,
      userId: json['userId'] as int,
      parentScheduleId: json['parentScheduleId'] as int?,
      name: json['name'] as String,
      content: json['content'] as String,
      startingAt: DateTime.parse(json['startingAt'] as String),
      endingAt: DateTime.parse(json['endingAt'] as String),
      isSuccess: json['isSuccess'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      repetitions: (json['repetitions'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'parentScheduleId': instance.parentScheduleId,
      'name': instance.name,
      'content': instance.content,
      'startingAt': instance.startingAt.toIso8601String(),
      'endingAt': instance.endingAt.toIso8601String(),
      'isSuccess': instance.isSuccess,
      'createdAt': instance.createdAt.toIso8601String(),
      'categories': instance.categories,
      'repetitions':
          instance.repetitions.map((e) => e.toIso8601String()).toList(),
    };
