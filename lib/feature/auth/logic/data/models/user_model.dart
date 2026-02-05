// =========================
// user_model.dart
// =========================
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.name,
    required super.uid,
    super.role = 'patient',
    super.doctorProfileCompleted = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(UserEntity user) => UserModel(
    email: user.email,
    name: user.name,
    uid: user.uid,
    role: user.role,
    doctorProfileCompleted: user.doctorProfileCompleted,
  );

  @override
  UserEntity toEntity() => UserEntity(
    uid: uid,
    name: name,
    email: email,
    role: role,
    doctorProfileCompleted: doctorProfileCompleted,
  );
}
