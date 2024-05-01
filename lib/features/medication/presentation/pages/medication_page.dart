import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradeuration/config/appconstnace/media.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/features/medication/presentation/bloc/medication_bloc.dart';
import 'package:gradeuration/features/medication/presentation/widgets/add_medication_widget.dart';
import 'package:gradeuration/features/medication/presentation/widgets/preview_medication.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constance/logic_const.dart';
import '../../../../core/tools/tools.dart';

class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicationBloc>(
      create: (context) => sl(),
      child: const MedicationView(),
    );
  }
}

class MedicationView extends StatefulWidget {
  const MedicationView({super.key});

  @override
  State<MedicationView> createState() => _MedicationViewState();
}

class _MedicationViewState extends State<MedicationView>
    with TickerProviderStateMixin {
  late final TabController _controller;
  late final MedicationBloc bloc;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    bloc = BlocProvider.of<MedicationBloc>(context);
    bloc.add(FetchMedicationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.medicatiokn),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 3000)),
              lastDate: DateTime.now(),
              onDateChanged: (value) {},
            ),
            TabBar(
              controller: _controller,
              tabs: [
                Tab(text: t.week),
                Tab(text: t.day),
              ],
            ),
            Expanded(
              child: BlocBuilder<MedicationBloc, MedicationState>(
                builder: (context, state) {
                  if (state is MedicationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MedicationSuccess) {
                    return TabBarView(
                      controller: _controller,
                      children: [
                        weekView(),
                        dayView(),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBtmSheet(context, AddMedicationWidget(bloc: bloc));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  weekView() {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(FetchMedicationEvent());
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: bloc.medications.length,
        itemBuilder: (context, index) {
          final medication = bloc.medications[index];
          return Column(
            children: [
              ListTile(
                onTap: () {
                  showBtmSheet(context,
                      PreviewMedication(medication: medication, bloc: bloc));
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
                  itemCount: medication.schedules.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: colorsSchedule[
                            Random().nextInt(colorsSchedule.length)],
                      ),
                      child: Center(
                        child: Text(
                          medication.schedules[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  dayView() {
    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(FetchMedicationEvent());
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: bloc.medications.length,
        itemBuilder: (context, index) {
          final medication = bloc.medications[index];
          return Column(
            children: [
              ListTile(
                onTap: () {
                  showBtmSheet(
                      context,
                      PreviewMedication(
                        medication: medication,
                        bloc: bloc,
                      ));
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
                  itemCount: medication.schedules.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: colorsSchedule[
                            Random().nextInt(colorsSchedule.length)],
                      ),
                      child: Center(
                        child: Text(
                          medication.schedules[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  monthView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bloc.medications.length,
      itemBuilder: (context, index) {
        final medication = bloc.medications[index];
        return Column(
          children: [
            ListTile(
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
                itemCount: medication.schedules.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: colorsSchedule[
                          Random().nextInt(colorsSchedule.length)],
                    ),
                    child: Center(
                      child: Text(
                        medication.schedules[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
