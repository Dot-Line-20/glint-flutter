// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Comment {
  String user_id;
  String post_id;
  String content;
  bool is_deleted;
  DateTime created_at;
  Comment({
    required this.user_id,
    required this.post_id,
    required this.content,
    required this.is_deleted,
    required this.created_at,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
