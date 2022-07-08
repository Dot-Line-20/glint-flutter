// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class User {
  String id;
  String name;
  String password;

  User({required this.id, required this.name, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
