import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity{
  UserModel({required super.email,
    required super.name,
    required super.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity user) =>
      UserModel(
          email: user.email,
          name: user.name,
          uid: user.uid);

  @override
  UserEntity toEntity() => UserEntity(
    uid: uid,
    name: name,
    email: email,
  );


}