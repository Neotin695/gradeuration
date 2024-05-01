part of 'medication_bloc.dart';

abstract class MedicationEvent extends Equatable {
  const MedicationEvent();

  @override
  List<Object> get props => [];
}

class FetchMedicationEvent extends MedicationEvent {}

class AddMedicationEvent extends MedicationEvent {}

class DeleteMedicationEvent extends MedicationEvent {
  final String id;

  const DeleteMedicationEvent(this.id);
}

class UpdateMedicationEvent extends MedicationEvent {}

class ChangeAmountValue extends MedicationEvent {
  final int value;

  const ChangeAmountValue(this.value);
}
