// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      name: json['name'] as String,
      user_id: json['user_id'] as String,
      target_user_id: json['target_user_id'] as String,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'name': instance.name,
      'user_id': instance.user_id,
      'target_user_id': instance.target_user_id,
    };
