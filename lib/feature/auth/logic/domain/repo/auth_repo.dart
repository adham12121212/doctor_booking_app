

import '../entity/user_entity.dart';

abstract class AuthRepo{
  Future<UserEntity> createEmailAndPassword(String name, String email ,String uid);
  Future<UserEntity> signInEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future addData({required UserEntity user});
  Future<UserEntity> getUser();

}