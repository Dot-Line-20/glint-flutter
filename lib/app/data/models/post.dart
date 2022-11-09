// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:glint/app/data/models/category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Media {
  int id;
  String name;
  String type;
  int userId;
  bool isImage;
  DateTime createdAt;

  Media({
    required this.name,
    required this.id,
    required this.type,
    required this.userId,
    required this.isImage,
    required this.createdAt,
  });
  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}

@JsonSerializable()
class Medias {
  int index;
  Media media;

  Medias({
    required this.index,
    required this.media,
  });
  factory Medias.fromJson(Map<String, dynamic> json) => _$MediasFromJson(json);
  Map<String, dynamic> toJson() => _$MediasToJson(this);
}

@JsonSerializable()
class Count {
  int likes;
  int comments;
  Count({
    required this.likes,
    required this.comments,
  });
  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);
  Map<String, dynamic> toJson() => _$CountToJson(this);
}

@JsonSerializable()
class Post {
  int id;
  int userId;
  String content;
  List<Medias> medias;
  DateTime createdAt;
  List<Categories> categories;
  bool isLiked;

  @JsonKey(name: '_count')
  Count count;
  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.medias,
    required this.createdAt,
    required this.categories,
    required this.count,
    required this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
