// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'chat.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Chat {
  String name;
  String user_id;
  String target_user_id;
  Chat(
      {required this.name,
      required this.user_id,
      required this.target_user_id});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
