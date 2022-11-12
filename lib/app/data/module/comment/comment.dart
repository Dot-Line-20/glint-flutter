// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Comment {
  int id;
  int userId;
  int postId;
  String content;
  DateTime createdAt;
  Comment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
