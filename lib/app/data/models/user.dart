// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class User {
  String email;
  String password;
  String name;
  DateTime birth;
  String image;
  DateTime created_at;
  User({
    required this.email,
    required this.password,
    required this.name,
    required this.birth,
    required this.image,
    required this.created_at,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
