// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      schedule_id: json['schedule_id'] as String,
      post_id: json['post_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'schedule_id': instance.schedule_id,
      'post_id': instance.post_id,
      'name': instance.name,
    };
