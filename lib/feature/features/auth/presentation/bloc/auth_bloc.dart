import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/feature/features/auth/data/models/user_profile_model.dart';
import 'package:gradeuration/feature/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:gradeuration/feature/features/auth/domain/usecases/signin_usecase.dart';
import 'package:gradeuration/feature/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  String phoneNum = '';
  AuthBloc(
    this._signInUsecase,
    this._signUpUsecase,
    this._forgotPasswordUsecase,
  ) : super(AuthInitial()) {
    on<SignInEvent>(_signinEvent);
    on<SignUpEvent>(_signupEvent);
    on<ForgotPasswordEvent>(_forgotPasswordEvent);
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
    emit(AuthLoading());
    try {
      await _signUpUsecase(
        UserProfileModel(
                id: '',
                userName: userName.text,
                phoneNumber: phoneNum,
                email: email.text,
                password: password.text,
                imageUrl: '',
                gander: '',
                dateOfBirth: '',
                location: '',
                fullName: fullName.text)
            .toJson(),
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
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
