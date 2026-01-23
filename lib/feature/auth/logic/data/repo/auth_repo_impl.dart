import 'dart:developer';
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
      // Create user in Firebase Auth
      final userCredential = await firebaseAuthService.createEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      // Create user entity
      final user = UserEntity(
        uid: userCredential.uid,
        name: name,
        email: email,
      );
      // Set the displayName in FirebaseAuth
      await userCredential.updateDisplayName(name);
      await userCredential.reload(); // Refresh user info

      // Save to Firestore
      await addData(user: user);
      log('User created and saved successfully');

      return user;
    } on NetworkExceptions {
      log('NetworkExceptions catch $NetworkExceptions');
      rethrow;
    } catch (e) {
      log('createEmailAndPassword error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }

  @override
  Future<UserEntity> signInEmailAndPassword(
      String email,
      String password,
      ) async {
    try {
      final userCredential =
      await firebaseAuthService.signInEmailAndPassword(
        email: email,
        password: password,
      );

      return UserEntity(
        uid: userCredential.uid,
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
      await fireStoreDataService.addData(
        path: EndPoint.addUser, // usually 'users'
        documentId: user.uid,
        data: UserModel.fromEntity(user).toMap(),
      );
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
      if (uid == null) {
        throw Exception("No logged-in user");
      }

      // Fetch single user document
      final dataList = await fireStoreDataService.getData(path: "${EndPoint.getUser}/$uid");

      if (dataList.isEmpty) {
        throw Exception("User data not found in Firestore");
      }

      final data = dataList.first; // Map<String, dynamic>

      return UserModel.fromJson(data).toEntity();
    } catch (e) {
      log('getUser error: $e');
      throw NetworkExceptions.unexpectedError();
    }
  }
}
