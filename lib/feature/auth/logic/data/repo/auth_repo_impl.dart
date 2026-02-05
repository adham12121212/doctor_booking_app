// =========================
// auth_repo_impl.dart  (FIXED getUser + default patient + merge-safe add)
// =========================
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booked_app/core/constants/end_points.dart';
import '../../../../../core/error_handler/network_exceptions.dart';
import '../../../../../core/service/firebase_auth_service.dart';
import '../../../../../core/service/firestore_data_service.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  final FireBaseAuthService firebaseAuthService;
  final FireStoreDataService fireStoreDataService;

  AuthRepoImpl(this.firebaseAuthService, this.fireStoreDataService);

  @override
  Future<UserEntity> createEmailAndPassword(String email, String password, String name) async {
    try {
      final userCredential = await firebaseAuthService.createEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      // ✅ default patient
      final user = UserEntity(
        uid: userCredential.uid,
        name: name,
        email: email,
        role: 'patient',
        doctorProfileCompleted: false,
      );

      await userCredential.updateDisplayName(name);
      await userCredential.reload();

      await addData(user: user);
      log('User created and saved successfully');

      return user;
    } on NetworkExceptions {
      rethrow;
    } catch (e) {
      log('createEmailAndPassword error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }

  @override
  Future<UserEntity> signInEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await firebaseAuthService.signInEmailAndPassword(
        email: email,
        password: password,
      );

      // ✅ ensure user doc exists + defaults (patient)
      final uid = userCredential.uid;
      final existing = await fireStoreDataService.getDoc(
        path: EndPoint.getUser,
        documentId: uid,
      );

      if (existing == null) {
        final user = UserEntity(
          uid: uid,
          email: email,
          name: userCredential.displayName ?? '',
          role: 'patient',
          doctorProfileCompleted: false,
        );
        await addData(user: user);
      } else {
        // merge defaults for old users
        await FirebaseFirestore.instance
            .collection(EndPoint.addUser)
            .doc(uid)
            .set({
          'role': existing['role'] ?? 'patient',
          'doctorProfileCompleted': existing['doctorProfileCompleted'] ?? false,
        }, SetOptions(merge: true));
      }

      return UserEntity(
        uid: uid,
        email: email,
        name: userCredential.displayName ?? '',
      );
    } on NetworkExceptions {
      rethrow;
    } catch (e) {
      log('signInEmailAndPassword error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuthService.signOut();
      log('User signed out');
    } catch (e) {
      log('signOut error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }

  @override
  Future addData({required UserEntity user}) async {
    try {
      // ✅ merge = true (so doctor flags won’t be overwritten later)
      await FirebaseFirestore.instance
          .collection(EndPoint.addUser)
          .doc(user.uid)
          .set(UserModel.fromEntity(user).toMap(), SetOptions(merge: true));

      log('User data saved to Firestore');
    } catch (e) {
      log('addData error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }

  @override
  Future<UserEntity> getUser() async {
    try {
      final uid = firebaseAuthService.getCurrentUserUid();
      if (uid == null) throw Exception("No logged-in user");

      final data = await fireStoreDataService.getDoc(
        path: EndPoint.getUser, // "user"
        documentId: uid,
      );

      if (data == null) throw Exception("User data not found in Firestore");

      return UserModel.fromJson(data).toEntity();
    } catch (e) {
      log('getUser error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }
}
