import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/constance/logic_const.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/medication/domain/entities/medication_entity.dart';
import 'package:gradeuration/features/medication/presentation/widgets/schedule_item.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/appconstnace/media.dart';
import '../bloc/medication_bloc.dart';

class PreviewMedication extends StatelessWidget {
  const PreviewMedication(
      {super.key, required this.medication, required this.bloc});
  final MedicationEntity medication;
  final MedicationBloc bloc;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicationBloc, MedicationState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is MedicationFailure) {
          BotToast.showText(text: state.message);
        }
        if (state is MedicationLoading) {
          BotToast.showLoading();
        }
        if (state is MedicationSuccess) {
          BotToast.closeAllLoading();

          context.pop();
        }
      },
      child: Scaffold(
        appBar: leadingAppBar(context, () {
          context.pop();
        }),
        body: Column(
          children: [
            SvgPicture.asset(Media.pill.path),
            const Spacer(),
            Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              color: const Color.fromARGB(255, 57, 57, 57),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSpace(3),
                    Text(
                      medication.title,
                      style: txtTheme(context)
                          .headlineMedium!
                          .copyWith(color: Colors.white),
                    ),
                    vSpace(2),
                    Text(
                      medication.title,
                      style: txtTheme(context).bodyLarge!.copyWith(
                            color: const Color.fromARGB(255, 111, 111, 111),
                          ),
                    ),
                    vSpace(1),
                    SizedBox(
                      height: 7.h,
                      width: 85.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: medication.schedules.length,
                        itemBuilder: (context, index) {
                          return ScheduleItem(
                            title: medication.schedules[index],
                          );
                        },
                      ),
                    ),
                    vSpace(1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardInfoMedication(
                          media: Media.amount,
                          title: t.amount,
                          value:
                              '${medication.pill} ${medication.type == Amount.pill.name ? t.pillText : t.doseText} / day',
                        ),
                        CardInfoMedication(
                          media: Media.duration,
                          title: t.thisMonth,
                          value: '${medication.taken}/',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardInfoMedication(
                          media: Media.cause,
                          title: t.cause,
                          value: medication.cause,
                        ),
                      ],
                    ),
                    vSpace(3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: () {}, child: Text(t.edit)),
                        vSpace(3),
                        ElevatedButton(
                            onPressed: () {
                              bloc.add(DeleteMedicationEvent(medication.id));
                            },
                            child: Text(t.remove)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardInfoMedication extends StatelessWidget {
  const CardInfoMedication({
    super.key,
    required this.media,
    required this.title,
    required this.value,
  });
  final Media media;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Container(
        width: 43.w,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              media.path,
              width: 40,
            ),
            hSpace(2),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: txtTheme(context)
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 13.sp),
                ),
                Text(
                  value,
                  style: txtTheme(context)
                      .bodyLarge!
                      .copyWith(color: randomColor()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
