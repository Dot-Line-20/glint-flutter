// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      user: (json['user'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'user': instance.user,
    };

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      id: json['id'] as int,
      name: json['name'] as String,
      users: Users.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'users': instance.users,
    };

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'user': instance.user,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int,
      userId: json['userId'] as int?,
      content: json['content'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
