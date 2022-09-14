// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      chat_id: json['chat_id'] as String,
      content: json['content'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'chat_id': instance.chat_id,
      'content': instance.content,
      'created_at': instance.created_at.toIso8601String(),
    };
