import 'package:get_it/get_it.dart';
import 'package:gradeuration/features/auth/data/datasources/auth_service.dart';
import 'package:gradeuration/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:gradeuration/features/auth/domain/repositories/auth_repo.dart';
import 'package:gradeuration/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:gradeuration/features/auth/domain/usecases/signin_usecase.dart';
import 'package:gradeuration/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gradeuration/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gradeuration/features/medication/data/datasources/medication_service.dart';
import 'package:gradeuration/features/medication/data/repositories/medication_repo_impl.dart';
import 'package:gradeuration/features/medication/domain/repositories/medication_repo.dart';
import 'package:gradeuration/features/medication/domain/usecases/add_medication_usecase.dart';
import 'package:gradeuration/features/medication/domain/usecases/delete_medication_usecase.dart';
import 'package:gradeuration/features/medication/domain/usecases/fetch_medications_usecase.dart';
import 'package:gradeuration/features/medication/domain/usecases/update_medication_usecase.dart';
import 'package:gradeuration/features/medication/presentation/bloc/medication_bloc.dart';
import 'package:gradeuration/features/settings/data/datasources/settings_service.dart';
import 'package:gradeuration/features/settings/domain/repositories/settings_repo.dart';
import 'package:gradeuration/features/settings/domain/usecases/update_user_profile.dart';
import 'package:gradeuration/features/settings/domain/usecases/upload_img_usecase.dart';
import 'package:gradeuration/features/settings/presentation/bloc/settings_bloc.dart';

import '../../features/settings/data/repositories/settings_repo_imple.dart';

final sl = GetIt.instance;

Future<void> initializeGetIt() async {
  // auth service
  sl.registerSingleton(AuthService());
  // settings service
  sl.registerSingleton(SettingsService());
  // medication service
  sl.registerSingleton(MedicationService());

  //auth repo
  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl()));
  // settings repo
  sl.registerSingleton<SettingsRepo>(SettingsRepoImpl(sl()));
  // medication rpeo
  sl.registerSingleton<MedicationRepo>(MedicationRepoImpl(sl()));

  //auth usecase
  sl.registerSingleton(SignInUsecase(sl()));
  sl.registerSingleton(SignUpUsecase(sl()));
  sl.registerSingleton(ForgotPasswordUsecase(sl()));
  // settings usecase
  sl.registerSingleton(UpdateProfileUsecsae(sl()));
  sl.registerSingleton(UploadImgUsecase(sl()));
  // medication usecase
  sl.registerSingleton(UpdateMedicationUsecase(sl()));
  sl.registerSingleton(FetchMedicationUsecase(sl()));
  sl.registerSingleton(AddMedicationUsecase(sl()));
  sl.registerSingleton(DeleteMedicationUsecase(sl()));

  // auth bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
  // settings bloc
  sl.registerFactory(() => SettingsBloc(sl(), sl()));
  // medication bloc
  sl.registerFactory(() => MedicationBloc(sl(), sl(), sl(), sl()));
}
