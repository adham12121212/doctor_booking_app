// =========================
// user_entity.dart
// =========================
class UserEntity {
  final String name;
  final String email;
  final String uid;
  // ✅ two-mode flags
  final String role; // "patient" | "doctor"
  final bool doctorProfileCompleted;

  UserEntity({
    required this.email,
    required this.name,
    required this.uid,
    this.role = 'patient',
    this.doctorProfileCompleted = false,
  });

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      name: name,
      email: email,
      role: role,
      doctorProfileCompleted: doctorProfileCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'doctorProfileCompleted': doctorProfileCompleted,
    };
  }
}
