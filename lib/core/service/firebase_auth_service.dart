
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:booked_app/core/error_handler/network_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {

Future<User> createEmailAndPassword({required String email, required String password, required String name}) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw const NetworkExceptions.unexpectedError();
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseService createUserWithEmailAndPass FirebaseAuthException catch $e');
      throw _mapFirebaseAuthException(e);
    } on SocketException {
      throw NetworkExceptions.noInternetConnection();
    } on TimeoutException {
      throw const NetworkExceptions.requestTimeout();
    } catch (e) {
      log('FirebaseService createUserWithEmailAndPass catch $e');
      throw const NetworkExceptions.unexpectedError();
    }

  }
Future<User> signInEmailAndPassword({required String email, required String password})async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (credential.user == null) {
        throw const NetworkExceptions.unexpectedError();
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseService createUserWithEmailAndPass FirebaseAuthException catch $e');
      throw _mapFirebaseAuthException(e);
    } on SocketException {
      throw NetworkExceptions.noInternetConnection();
    } on TimeoutException {
      throw const NetworkExceptions.requestTimeout();
    } catch (e) {
      log('FirebaseService createUserWithEmailAndPass catch $e');
      throw const NetworkExceptions.unexpectedError();
    }
  }
Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
   }
String? getCurrentUserUid() {
  return FirebaseAuth.instance.currentUser?.uid;
}
bool isLoggedIn(){
  return FirebaseAuth.instance.currentUser != null;
}




  NetworkExceptions _mapFirebaseAuthException(FirebaseAuthException e,) {
    switch (e.code) {
      case 'user-not-found':
        return const NetworkExceptions.unauthorizedRequest(
          'No user found for this email',
        );
      case 'wrong-password':
        return const NetworkExceptions.unauthorizedRequest(
          'Wrong password',
        );
      case 'invalid-email':
        return const NetworkExceptions.badRequest();
      case 'user-disabled':
        return const NetworkExceptions.unauthorizedRequest(
          'This user has been disabled',
        );
      case 'invalid-credential':
        return const NetworkExceptions.unauthorizedRequest(
          'wrong email or password',
        );
      case 'network-request-failed':
        return const NetworkExceptions.noInternetConnection();
      default:
        return NetworkExceptions.defaultError(
          e.message ?? 'Authentication error',
        );
    }
  }

}