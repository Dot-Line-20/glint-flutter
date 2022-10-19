// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Medias {
  int postId;
  String id;
  String type;
  Medias({
    required this.postId,
    required this.id,
    required this.type,
  });
  factory Medias.fromJson(Map<String, dynamic> json) => _$MediasFromJson(json);
  Map<String, dynamic> toJson() => _$MediasToJson(this);
}

@JsonSerializable()
class Counts {
  int likes;
  Counts({
    required this.likes,
  });
  factory Counts.fromJson(Map<String, dynamic> json) => _$CountsFromJson(json);
  Map<String, dynamic> toJson() => _$CountsToJson(this);
}

@JsonSerializable()
class Post {
  int userId;
  String title;
  String content;
  String meias;
  DateTime createdAt;
  Post({
    required this.userId,
    required this.title,
    required this.content,
    required this.meias,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
