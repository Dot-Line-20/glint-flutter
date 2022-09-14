// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Post {
  String user_id;
  String title;
  String content;
  String meias;
  bool is_deleted;
  DateTime created_at;
  Post({
    required this.user_id,
    required this.title,
    required this.content,
    required this.meias,
    required this.is_deleted,
    required this.created_at,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
