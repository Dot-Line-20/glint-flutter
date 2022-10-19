import 'package:json_annotation/json_annotation.dart';
part 'test_model.g.dart';

@JsonSerializable()
class TestPost {
  int userId;
  int id;
  String title;
  String body;

  TestPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory TestPost.fromJson(Map<String, dynamic> json) =>
      _$TestPostFromJson(json);

  Map<String, dynamic> toJson() => _$TestPostToJson(this);
}
