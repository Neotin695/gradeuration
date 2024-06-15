import 'package:dio/dio.dart';
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

import '../../features/medication/domain/usecases/fetch_medication_usecase.dart';
import '../../features/settings/data/repositories/settings_repo_imple.dart';
import '../../features/task/data/datasources/task_service.dart';
import '../../features/task/data/repositories/task_repo_impl.dart';
import '../../features/task/domain/repositories/task_repo.dart';
import '../../features/task/domain/usecases/add_mission_usecase.dart';
import '../../features/task/domain/usecases/add_tasks_usecase.dart';
import '../../features/task/domain/usecases/delete_tasks_usecase.dart';
import '../../features/task/domain/usecases/edit_tasks_usecase.dart';
import '../../features/task/domain/usecases/fetch_mission_usecase.dart';
import '../../features/task/domain/usecases/fetch_tasks_usecase.dart';
import '../../features/task/presentation/bloc/task_bloc.dart';
import '../global_archtiecture/data/datasource/notification_messaging_service.dart';
import '../global_archtiecture/data/repo_impl/global_repo_impl.dart';
import '../global_archtiecture/domain/repo/global_repo.dart';
import '../global_archtiecture/domain/usecases/send_notification_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeGetIt() async {
  // auth service
  sl.registerSingleton(AuthService());
  // settings service
  sl.registerSingleton(SettingsService());
  // global feature
  sl.registerSingleton(NotificationMessagingService(Dio()));
  // medication service
  sl.registerSingleton(MedicationService());
  // task service
  sl.registerSingleton(TaskService());

  //auth repo
  sl.registerSingleton<AuthRepo>(AuthRepoImpl(sl()));
  // settings repo
  sl.registerSingleton<SettingsRepo>(SettingsRepoImpl(sl()));
  // global feature
  sl.registerSingleton<GlobalRepo>(GlobalRepoImpl(sl()));
  // medication rpeo
  sl.registerSingleton<MedicationRepo>(MedicationRepoImpl(sl()));
  // task repo
  sl.registerSingleton<TaskRepo>(TaskRepoImpl(sl()));

  // global usecase
  sl.registerSingleton(SendNotificationUsecase(sl()));
  //auth usecase
  sl.registerSingleton(SignInUsecase(sl()));
  sl.registerSingleton(SignUpUsecase(sl()));
  sl.registerSingleton(ForgotPasswordUsecase(sl()));
  // settings usecase
  sl.registerSingleton(UpdateProfileUsecsae(sl()));
  sl.registerSingleton(UploadImgUsecase(sl()));
  // medication usecase
  sl.registerSingleton(UpdateMedicationUsecase(sl()));
  sl.registerSingleton(FetchMedicationsUsecase(sl()));
  sl.registerSingleton(FetchMedicationUsecase(sl()));
  sl.registerSingleton(AddMedicationUsecase(sl()));
  sl.registerSingleton(DeleteMedicationUsecase(sl()));
  // task usecase
  sl.registerSingleton(FetchTasksUsecase(sl()));
  sl.registerSingleton(EditTaskUsecase(sl()));
  sl.registerSingleton(DeleteTaskUsecase(sl()));
  sl.registerSingleton(AddTaskUsecase(sl()));
  sl.registerSingleton(AddMissionUsecase(sl()));
  sl.registerSingleton(FetchMissionUsecase(sl()));

  // auth bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
  // settings bloc
  sl.registerFactory(() => SettingsBloc(sl(), sl()));
  // medication bloc
  sl.registerFactory(() => MedicationBloc(sl(), sl(), sl(), sl(), sl()));
  // task bloc
  sl.registerFactory(() => TaskBloc(sl(), sl(), sl(), sl(), sl(), sl()));
}
