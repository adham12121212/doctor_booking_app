import 'package:get_it/get_it.dart';
import '../../feature/auth/logic/data/repo/auth_repo_impl.dart';
import '../../feature/auth/logic/domain/repo/auth_repo.dart';
import '../../feature/auth/sigup/presentation/cubit/signup_cubit.dart';
import '../../feature/booked/data/booked_repo_impl/booked_repo_impl.dart';
import '../../feature/booked/domain/booked_repo/booked_repo.dart';
import '../../feature/home/data/repo/home_repo_impl.dart';
import '../../feature/home/domain/repo/home_repo.dart';
import '../service/firebase_auth_service.dart';
import '../service/firestore_data_service.dart';
import '../service/firestore_data_service_impl.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      getIt.get<FireBaseAuthService>(),
      getIt.get<FirestoreDataServiceImpl>(),
    ),
  );
  getIt.registerLazySingleton<FireBaseAuthService>(() => FireBaseAuthService());
  getIt.registerLazySingleton<FirestoreDataServiceImpl>(() => FirestoreDataServiceImpl());
  getIt.registerLazySingleton<SignupCubit>(
    () => SignupCubit(getIt.get<AuthRepo>()),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt.get<FirestoreDataServiceImpl>()),
  );
  getIt.registerLazySingleton<BookedRepo>(
    () => BookedRepoImpl(getIt.get<FirestoreDataServiceImpl>()),
  );
}
