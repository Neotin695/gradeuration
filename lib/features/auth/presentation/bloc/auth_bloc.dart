import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/core/helper/firebase_messaging.dart';
import 'package:gradeuration/core/helper/notification_service.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/auth/data/models/user_profile_model.dart';
import 'package:gradeuration/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:gradeuration/features/auth/domain/usecases/signin_usecase.dart';
import 'package:gradeuration/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';
import 'package:gradeuration/features/medication/domain/usecases/fetch_medications_usecase.dart';
import 'package:intl/intl.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final FetchMedicationsUsecase _fetchMedicationUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController city = TextEditingController();
  String phoneNum = '';
  String selectedGendar = t.male;
  String selectedDiagnosis = t.anemia;
  String selectedStage = t.little;
  String docImage = '';
  DateTime? selectedDate;
  List<MedicationEntity> medications = [];
  AuthBloc(
    this._signInUsecase,
    this._signUpUsecase,
    this._forgotPasswordUsecase,
    this._fetchMedicationUsecase,
  ) : super(AuthInitial()) {
    on<SignInEvent>(_signinEvent);
    on<SignUpEvent>(_signupEvent);
    on<ForgotPasswordEvent>(_forgotPasswordEvent);
    on<FetchMedicationEvent>(_fetchMedicationsEvent);
  }

  FutureOr<void> _fetchMedicationsEvent(event, Emitter emit) async {
    emit(AuthLoading());
    try {
      medications = await _fetchMedicationUsecase({});
      for (var medication in medications) {
        if (medication.frequencyType == 'daily') {
          NotificationService.showScheduleNotificationDay(medication, '');
        } else {
          NotificationService.showScheduleNotificationWeek(medication, '');
        }
      }
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  FutureOr<void> _forgotPasswordEvent(event, emit) async {
    emit(AuthLoading());
    try {
      await _forgotPasswordUsecase({'email': email.text});
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  FutureOr<void> _signupEvent(event, emit) async {
    if (validateEmail) {
      emit(AuthLoading());

      try {
        await _signUpUsecase(
          UserProfileModel(
            id: '',
            userName: userName.text,
            phoneNumber: phoneNum,
            tasks: [],
            email: email.text,
            diagnosis: selectedDiagnosis,
            stage: selectedStage,
            password: password.text,
            medicalReportImg: docImage,
            role: 'Patient',
            profileImg: '',
            gander: selectedGendar,
            dateOfBirth: DateFormat.yMEd().format(selectedDate!),
            location: city.text,
            fullName: fullName.text,
            medications: const [],
            token: (await FirebaseMessagingService.instance.generateToken)!,
          ).toJson(),
        );
        emit(AuthSuccess());
        email.clear();
        password.clear();
        fullName.clear();
        selectedDate = null;
        phoneNum = '';
        city.clear();
        userName.clear();
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    } else {
      emit(const AuthFailure('invalid'));
    }
  }

  bool get validateEmail {
    return email.text.isNotEmpty &&
        fullName.text.isNotEmpty &&
        password.text.isNotEmpty &&
        userName.text.isNotEmpty &&
        city.text.isNotEmpty &&
        phoneNum.isNotEmpty &&
        selectedDate != null;
  }

  FutureOr<void> _signinEvent(event, emit) async {
    emit(AuthLoading());
    try {
      await _signInUsecase({'email': email.text, 'password': password.text});
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
