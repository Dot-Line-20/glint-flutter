// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      birth: DateTime.parse(json['birth'] as String),
      image: json['image'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'birth': instance.birth.toIso8601String(),
      'image': instance.image,
      'createdAt': instance.createdAt.toIso8601String(),
      'media': instance.media,
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
      successRate: json['successRate'] as int?,
      followers: json['followers'] as int,
      following: json['following'] as int,
    );

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'successRate': instance.successRate,
      'followers': instance.followers,
      'following': instance.following,
    };
