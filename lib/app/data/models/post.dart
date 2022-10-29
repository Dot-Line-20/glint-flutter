// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

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
  bool isLiked;

  Media(
      {required this.name,
      required this.id,
      required this.type,
      required this.userId,
      required this.isImage,
      required this.createdAt,
      required this.isLiked});
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
  Count({
    required this.likes,
  });
  factory Count.fromJson(Map<String, dynamic> json) => _$CountFromJson(json);
  Map<String, dynamic> toJson() => _$CountToJson(this);
}

@JsonSerializable()
class Post {
  int id;
  int userId;
  String title;
  String content;
  List<Medias> medias;
  DateTime createdAt;

  @JsonKey(name: '_count')
  Count count;
  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.medias,
    required this.createdAt,
    required this.count,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
