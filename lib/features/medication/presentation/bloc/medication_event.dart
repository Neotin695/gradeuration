part of 'medication_bloc.dart';

abstract class MedicationEvent extends Equatable {
  const MedicationEvent();

  @override
  List<Object> get props => [];
}

class FetchMedicationsEvent extends MedicationEvent {}

class AddMedicationEvent extends MedicationEvent {}

class MedicationNotTake extends MedicationEvent {}

class DeleteMedicationEvent extends MedicationEvent {
  final String id;

  const DeleteMedicationEvent(this.id);
}

class UpdateMedicationEvent extends MedicationEvent {
  final MedicationEntity medication;

  const UpdateMedicationEvent(this.medication);
}

class ChangeAmountValue extends MedicationEvent {
  final int value;

  const ChangeAmountValue(this.value);
}

class FetchMedicationEvent extends MedicationEvent {
  final String id;

  const FetchMedicationEvent(this.id);
}
