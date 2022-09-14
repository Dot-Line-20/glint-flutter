// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Category {
  String schedule_id;
  String post_id;
  String name;

  Category({
    required this.schedule_id,
    required this.post_id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
