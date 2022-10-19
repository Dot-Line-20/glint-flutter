// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medias _$MediasFromJson(Map<String, dynamic> json) => Medias(
      postId: json['postId'] as int,
      id: json['id'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$MediasToJson(Medias instance) => <String, dynamic>{
      'postId': instance.postId,
      'id': instance.id,
      'type': instance.type,
    };

Counts _$CountsFromJson(Map<String, dynamic> json) => Counts(
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$CountsToJson(Counts instance) => <String, dynamic>{
      'likes': instance.likes,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      meias: json['meias'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'meias': instance.meias,
      'createdAt': instance.createdAt.toIso8601String(),
    };
