import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/injection_container.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/medication_bloc.dart';
import '../widgets/add_medication_widget.dart';
import '../widgets/medication_item.dart';

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
    bloc.add(FetchMedicationsEvent());
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bloc.medications
          .where((element) => element.frequencyType == 'weekly')
          .toList()
          .length,
      itemBuilder: (context, index) {
        if (bloc.medications.isNotEmpty) {
          final medication = bloc.medications[index];
          return MedicationItem(medication: medication, bloc: bloc);
        }
        return emptyWidget;
      },
    );
  }

  dayView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bloc.medications
          .where((element) => element.frequencyType == 'daily')
          .toList()
          .length,
      itemBuilder: (context, index) {
        if (bloc.medications.isNotEmpty) {
          final medication = bloc.medications[index];
          return MedicationItem(medication: medication, bloc: bloc);
        }
        return emptyWidget;
      },
    );
  }
}
