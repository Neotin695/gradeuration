// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/constance/logic_const.dart';
import 'package:gradeuration/core/tools/shared/txt_field.dart';
import 'package:sizer/sizer.dart';

import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/features/medication/presentation/bloc/medication_bloc.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/tools/tools.dart';
import '../widgets/preview_medication.dart';
import '../widgets/schedule_item.dart';

class MedicationNotifyPage extends StatelessWidget {
  const MedicationNotifyPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicationBloc>(
      create: (context) => sl()..add(FetchMedicationEvent(id)),
      child: const MedicationNotifyView(),
    );
  }
}

class MedicationNotifyView extends StatefulWidget {
  const MedicationNotifyView({super.key});

  @override
  State<MedicationNotifyView> createState() => _MedicationNotifyViewState();
}

class _MedicationNotifyViewState extends State<MedicationNotifyView> {
  late final MedicationBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MedicationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MedicationBloc, MedicationState>(
        builder: (context, state) {
          if (state is MedicationFailure) {
            BotToast.showText(text: state.message);
          }
          if (state is MedicationLoading) return loading;

          if (state is MedicationSuccess) {
            if (bloc.medication == null) return empty;
            return Column(
              children: [
                SvgPicture.asset(
                  Media.pill.path,
                  width: 30.w,
                ),
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
                          bloc.medication!.title,
                          style: txtTheme(context)
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                        vSpace(2),
                        Text(
                          bloc.medication!.description,
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
                            itemCount: bloc.medication!.daysOfWeek.length,
                            itemBuilder: (context, index) {
                              return ScheduleItem(
                                title: bloc.medication!.daysOfWeek[index],
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
                                  '${bloc.medication!.totalDoses} ${bloc.medication!.doseType == Amount.pill.name ? t.pillText : t.doseText} / day',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardInfoMedication(
                              media: Media.cause,
                              title: t.cause,
                              value: bloc.medication!.cause,
                            ),
                          ],
                        ),
                        vSpace(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          children: [
                                            headingTitle(
                                                context, t.reasonMedication),
                                            vSpace(2),
                                            TxtField(
                                                cn: bloc.reason,
                                                label: t.reason),
                                            vSpace(3),
                                            ElevatedButton(
                                                onPressed: () {
                                                  bloc.add(
                                                    UpdateMedicationEvent(
                                                        bloc.medication!),
                                                  );
                                                },
                                                child: Text(t.upload))
                                          ],
                                        );
                                      });
                                },
                                child: Text(t.no)),
                            vSpace(3),
                            ElevatedButton(
                                onPressed: () {
                                  bloc.add(
                                    UpdateMedicationEvent(bloc.medication!),
                                  );
                                },
                                child: Text(t.take)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return empty;
        },
      ),
    );
  }
}
