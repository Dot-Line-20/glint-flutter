// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      user_id: json['user_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      meias: json['meias'] as String,
      is_deleted: json['is_deleted'] as bool,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'title': instance.title,
      'content': instance.content,
      'meias': instance.meias,
      'is_deleted': instance.is_deleted,
      'created_at': instance.created_at.toIso8601String(),
    };
