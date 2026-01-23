import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:booked_app/feature/auth/logic/domain/entity/user_entity.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error_handler/network_exceptions.dart';
import '../../../logic/domain/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;

  Future<void> loginEmailAndPassword({required String email ,required String password})async{
     emit(LoginLoading());
     try{
         final userEntity = await authRepo.signInEmailAndPassword(email,password);
         emit(LoginSuccess(userEntity));
     }on NetworkExceptions catch (e) {
       log('catch in cubit login network exception: $e');
       emit(LoginFailure(error:NetworkExceptions.getErrorMessage(e)));
     } catch (e) {
       log('catch in cubit login catch: $e');
       emit(LoginFailure(error: e.toString()));
     }

  }


}
