// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      name: json['name'] as String,
      id: json['id'] as int,
      type: json['type'] as String,
      userId: json['userId'] as int,
      isImage: json['isImage'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'userId': instance.userId,
      'isImage': instance.isImage,
      'createdAt': instance.createdAt.toIso8601String(),
    };

Medias _$MediasFromJson(Map<String, dynamic> json) => Medias(
      index: json['index'] as int,
      media: Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediasToJson(Medias instance) => <String, dynamic>{
      'index': instance.index,
      'media': instance.media,
    };

Count _$CountFromJson(Map<String, dynamic> json) => Count(
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$CountToJson(Count instance) => <String, dynamic>{
      'likes': instance.likes,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      medias: (json['medias'] as List<dynamic>)
          .map((e) => Medias.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: Count.fromJson(json['_count'] as Map<String, dynamic>),
      isLiked: json['isLiked'] as bool,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'medias': instance.medias,
      'createdAt': instance.createdAt.toIso8601String(),
      'categories': instance.categories,
      'isLiked': instance.isLiked,
      '_count': instance.count,
    };
