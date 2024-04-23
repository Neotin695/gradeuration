import 'package:get_it/get_it.dart';
import 'package:gradeuration/features/auth/data/datasources/auth_service.dart';
import 'package:gradeuration/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:gradeuration/features/auth/domain/repositories/auth_repo.dart';
import 'package:gradeuration/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:gradeuration/features/auth/domain/usecases/signin_usecase.dart';
import 'package:gradeuration/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gradeuration/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeGetIt() async {
  // auth service
  sl.registerSingleton(AuthService());

  //auth repo
  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl()));

  //auth usecase
  sl.registerSingleton(SignInUsecase(sl()));
  sl.registerSingleton(SignUpUsecase(sl()));
  sl.registerSingleton(ForgotPasswordUsecase(sl()));

  // auth bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
}
