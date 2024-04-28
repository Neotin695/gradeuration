import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/core/constance/logic_const.dart';
import 'package:gradeuration/features/medication/data/models/medication_model.dart';
import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';
import 'package:gradeuration/features/medication/domain/usecases/add_medication_usecase.dart';
import 'package:gradeuration/features/medication/domain/usecases/delete_medication_usecase.dart';
import 'package:gradeuration/features/medication/domain/usecases/fetch_medications_usecase.dart';
import 'package:gradeuration/features/medication/domain/usecases/update_medication_usecase.dart';

part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final UpdateMedicationUsecase _updateMedicationUsecase;
  final FetchMedicationUsecase _fetchMedicationUsecase;
  final AddMedicationUsecase _addMedicationUsecase;
  final DeleteMedicationUsecase _deleteMedicationUsecase;
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  List<String> schedules = [];
  int duration = 30;
  String frequency = Frequency.daily.name;
  int timesPerWeek = 2;
  List<MedicationEntity> medications = [];
  MedicationBloc(this._updateMedicationUsecase, this._fetchMedicationUsecase,
      this._addMedicationUsecase, this._deleteMedicationUsecase)
      : super(MedicationInitial()) {
    on<FetchMedicationEvent>(_fetchMedicationsEvent);
    on<AddMedicationEvent>(_addMedicationEvent);
    on<UpdateMedicationEvent>(_updateMedicationEvent);
    on<DeleteMedicationEvent>(_deleteMedicationEvent);
  }

  FutureOr<void> _deleteMedicationEvent(event, emit) async {
    emit(MedicationLoading());
    await _deleteMedicationUsecase(event.medication);
    emit(MedicationSuccess());
  }

  FutureOr<void> _updateMedicationEvent(event, emit) async {
    emit(MedicationLoading());
    // await _updateMedicationUsecase();
    emit(MedicationSuccess());
  }

  FutureOr<void> _addMedicationEvent(event, emit) async {
    emit(MedicationLoading());
    await _addMedicationUsecase(MedicationModel(
      id: '',
      title: title.text,
      description: description.text,
      schedules: schedules,
      duration: duration,
      frequency: frequency,
      timesPerWeek: timesPerWeek,
    ).toJson());
    emit(MedicationSuccess());
  }

  FutureOr<void> _fetchMedicationsEvent(event, emit) async {
    emit(MedicationLoading());
    await emit.forEach(_fetchMedicationUsecase({}), onData: (data) {
      medications = data;

      return MedicationSuccess();
    }, onError: (er, err) {
      return MedicationFailure(er.toString());
    });
  }
}
