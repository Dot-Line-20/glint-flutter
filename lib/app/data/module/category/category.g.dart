// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      scheduleId: json['scheduleId'] as int,
      categoryId: json['categoryId'] as int,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'categoryId': instance.categoryId,
    };
