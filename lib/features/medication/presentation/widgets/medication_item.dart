import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/tools/tools.dart';
import '../../domain/entities/medication_entity.dart';
import '../bloc/medication_bloc.dart';
import 'preview_medication.dart';

class MedicationItem extends StatelessWidget {
  const MedicationItem({
    super.key,
    required this.medication,
    required this.bloc,
  });

  final MedicationEntity medication;
  final MedicationBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            showBtmSheet(
                context, PreviewMedication(medication: medication, bloc: bloc));
          },
          leading: CircleAvatar(
            radius: 25,
            child: SvgPicture.asset(Media.pill.path),
          ),
          title: Text(medication.title),
          subtitle: Text(medication.description),
        ),
        SizedBox(
          height: 6.h,
          width: 85.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: medication.daysOfWeek.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(7),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: randomColor(),
                ),
                child: Center(
                  child: Text(
                    medication.daysOfWeek[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
