// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Message {
  String chat_id;
  String content;
  DateTime created_at;
  Message({
    required this.chat_id,
    required this.content,
    required this.created_at,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
