import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/features/medication/domain/usecases/fetch_medication_usecase.dart';

import '../../../../core/constance/logic_const.dart';
import '../../data/models/medication_model.dart';
import '../../domain/entities/medication_entity.dart';
import '../../domain/usecases/add_medication_usecase.dart';
import '../../domain/usecases/delete_medication_usecase.dart';
import '../../domain/usecases/fetch_medications_usecase.dart';
import '../../domain/usecases/update_medication_usecase.dart';
import 'package:intl/intl.dart';

part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final UpdateMedicationUsecase _updateMedicationUsecase;
  final FetchMedicationsUsecase _fetchMedicationsUsecase;
  final FetchMedicationUsecase _fetchMedicationUsecase;
  final AddMedicationUsecase _addMedicationUsecase;
  final DeleteMedicationUsecase _deleteMedicationUsecase;
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController cause = TextEditingController();
  final TextEditingController duration = TextEditingController();
  final TextEditingController reason = TextEditingController();
  List<String> daysOfWeek = [];
  List<String> selectedDays = [];
  int dosesPerTimes = 2;
  Amount doseType = Amount.dose;
  String frequencyType = Frequency.daily.name;
  int timesPerDay = 2;
  MedicationEntity? medication;
  List<MedicationEntity> medications = [];
  MedicationBloc(
    this._updateMedicationUsecase,
    this._fetchMedicationsUsecase,
    this._addMedicationUsecase,
    this._deleteMedicationUsecase,
    this._fetchMedicationUsecase,
  ) : super(MedicationInitial()) {
    on<FetchMedicationsEvent>(_fetchMedicationsEvent);
    on<AddMedicationEvent>(_addMedicationEvent);
    on<UpdateMedicationEvent>(_updateMedicationEvent);
    on<DeleteMedicationEvent>(_deleteMedicationEvent);
    on<ChangeAmountValue>(_changeAmountValue);
    on<FetchMedicationEvent>((event, emit) async {
      emit(MedicationLoading());
      try {
        medication = await _fetchMedicationUsecase({'id': event.id});
        emit(MedicationSuccess());
      } catch (e) {
        emit(MedicationFailure(e.toString()));
      }
    });
  }

  FutureOr<void> _changeAmountValue(event, emit) {
    if (event.value > 1) {
      dosesPerTimes = event.value;
    }
  }

  FutureOr<void> _deleteMedicationEvent(event, emit) async {
    emit(MedicationLoading());
    await _deleteMedicationUsecase({'id': event.id});
    emit(MedicationSuccess());
  }

  FutureOr<void> _updateMedicationEvent(
      UpdateMedicationEvent event, emit) async {
    emit(MedicationLoading());
    final medicationHistory = event.medication.takeHistory;
    medicationHistory.add({
      'description': reason.text.isEmpty ? 'Take Successfully!!' : reason.text,
      'time': DateFormat('yy-mm-dd hh:MM a').format(DateTime.now()),
    });
    await _updateMedicationUsecase(
        MedicationModel.fromEntity(event.medication.copyWith(
      takeHistory: medicationHistory,
      totalDoses: medications.isEmpty ? event.medication.totalDoses + 1 : null,
      title: title.text.isEmpty ? null : title.text,
      description: description.text.isEmpty ? null : description.text,
      duration: duration.text.isEmpty ? null : int.parse(duration.text),
      timesPerDay: timesPerDay,
      dosesPerTimes: dosesPerTimes,
      frequencyType: frequencyType,
      daysOfWeek: selectedDays,
      doseType: doseType.name,
    )).toJson());
    try {
      emit(MedicationSuccess());
    } catch (e) {
      emit(MedicationFailure(e.toString()));
    }
  }

  FutureOr<void> _addMedicationEvent(event, emit) async {
    emit(MedicationLoading());
    try {
      await _addMedicationUsecase({
        'medication': MedicationModel(
          id: '',
          userId: currentUser.id,
          title: title.text,
          description: description.text,
          daysOfWeek: daysOfWeek,
          duration: int.parse(duration.text),
          totalDoses: 0,
          doseType: doseType.name,
          cause: cause.text,
          timesPerDay: timesPerDay,
          whoAdded: 'patient',
          doctorId: '',
          dosesPerTimes: dosesPerTimes,
          frequencyType: frequencyType,
          takeHistory: [],
        ).toJson(),
      });
      title.clear();
      description.clear();
      emit(MedicationSuccess());
    } catch (e) {
      emit(MedicationFailure(e.toString()));
    }
  }

  FutureOr<void> _fetchMedicationsEvent(event, Emitter emit) async {
    emit(MedicationLoading());
    try {
      medications = await _fetchMedicationsUsecase({});
      emit(MedicationSuccess());
    } catch (e) {
      emit(MedicationFailure(e.toString()));
    }
  }
}
