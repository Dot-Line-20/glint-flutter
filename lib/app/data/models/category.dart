// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Category {
  int id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Categories {
  int? scheduleId;
  int? categoryId;
  Category category;

  Categories({
    this.scheduleId,
    this.categoryId,
    required this.category,
  });
  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}
