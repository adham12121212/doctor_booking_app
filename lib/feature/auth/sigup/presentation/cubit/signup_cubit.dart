import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/error_handler/network_exceptions.dart';
import '../../../logic/domain/entity/user_entity.dart';
import '../../../logic/domain/repo/auth_repo.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;



  Future<void>createEmailAndPassword(String email, String password, String name)async{
    emit(SignupLoading());
    try {
      final userEntity = await authRepo.createEmailAndPassword(email, password, name);

      emit(SignupSuccess(userEntity));
    } on NetworkExceptions catch (e) {
      log('catch in cubit signup network exception: $e');
      emit(SignupFailure(error:NetworkExceptions.getErrorMessage(e)));
    } catch (e) {
      log('catch in cubit signup catch: $e');
      emit(SignupFailure(error: e.toString()));
    }
  }

  Future<void> getUser() async{
     try {
        final userEntity = await authRepo.getUser();
        emit(SignupSuccess(userEntity));
     } catch (e) {
       log('catch in cubit signup network exception: $e');
       emit(SignupFailure(error: e.toString()));
     }
  }



}
