part of 'medication_bloc.dart';

abstract class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object> get props => [];
}

class MedicationInitial extends MedicationState {}

class MedicationLoading extends MedicationState {}

class MedicationSuccess extends MedicationState {}

class MedicationFailure extends MedicationState {
  final String message;

  const MedicationFailure(this.message);
}
