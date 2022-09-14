// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      user_id: json['user_id'] as String,
      post_id: json['post_id'] as String,
      content: json['content'] as String,
      is_deleted: json['is_deleted'] as bool,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'post_id': instance.post_id,
      'content': instance.content,
      'is_deleted': instance.is_deleted,
      'created_at': instance.created_at.toIso8601String(),
    };
