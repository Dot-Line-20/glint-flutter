// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:glint/app/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Users {
  List<User> user;

  Users({
    required this.user,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@JsonSerializable()
class ChatRoom {
  int id;
  String name;
  Users users;

  ChatRoom({
    required this.id,
    required this.name,
    required this.users,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

@JsonSerializable()
class ChatMessage {
  int id;
  String content;
  DateTime createdAt;
  User user;

  ChatMessage({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}

@JsonSerializable()
class Message {
  int id;
  int? userId;
  String content;
  DateTime? createdAt;
  Message({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
