import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
final class User {
  @JsonKey(includeIfNull: false)
  final String? id;
  final String name;
  final String password;

  const User({
    this.id,
    required this.name,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
