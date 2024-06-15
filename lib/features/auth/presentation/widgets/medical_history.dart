// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:gradeuration/core/tools/shared/custom_drop_down.dart';

import '../../../../core/constance/logic_const.dart';
import '../../../../core/tools/shared/pick_img_widget.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/auth_bloc.dart';

class MedicalHistoryWidget extends StatefulWidget {
  const MedicalHistoryWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final AuthBloc bloc;

  @override
  State<MedicalHistoryWidget> createState() => _MedicalHistoryWidgetState();
}

class _MedicalHistoryWidgetState extends State<MedicalHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          headingTitle(context, t.letsSetup),
          Text(
            t.aFewStepsAheads,
            style: txtTheme(context)
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(t.medicalHistory),
          vSpace(2),
          CustomDropdown(
              list: diagnosis,
              onChange: (value) {
                widget.bloc.selectedDiagnosis = value!;
                setState(() {});
              },
              value: widget.bloc.selectedDiagnosis),
          vSpace(2),
          CustomDropdown(
              list: stage,
              onChange: (value) {
                widget.bloc.selectedStage = value!;
                setState(() {});
              },
              value: widget.bloc.selectedStage),
          vSpace(3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                t.medicalHistory,
                style: txtTheme(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          PickDocWidget(path: widget.bloc.docImage),
          OutlinedButton(
              onPressed: () async {
                widget.bloc.docImage =
                    (await CunningDocumentScanner.getPictures(
                            isGalleryImportAllowed: true))!
                        .first;
                setState(() {});
              },
              child: Text(t.upload)),
        ],
      ),
    );
  }
}
