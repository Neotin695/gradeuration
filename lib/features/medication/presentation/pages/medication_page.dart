import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradeuration/core/service/injection_container.dart';
import 'package:gradeuration/features/medication/presentation/bloc/medication_bloc.dart';
import 'package:gradeuration/features/medication/presentation/widgets/add_medication_widget.dart';

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
    _controller = TabController(length: 3, vsync: this);
    bloc = BlocProvider.of<MedicationBloc>(context);
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
              firstDate: DateTime.now().subtract(Duration(days: 3000)),
              lastDate: DateTime.now(),
              onDateChanged: (value) {},
            ),
            TabBar(
              controller: _controller,
              tabs: [
                Tab(text: t.week),
                Tab(text: t.day),
                Tab(text: t.month),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  weekView(),
                  dayView(),
                  monthView(),
                ],
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
    return BlocBuilder<MedicationBloc, MedicationState>(
      builder: (context, state) {
        if (state is MedicationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MedicationFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is MedicationSuccess) {
          return Expanded(
            child: ListView.builder(
              itemCount: bloc.medications.length,
              itemBuilder: (context, index) {
                final medication = bloc.medications[index];
                return ListTile(
                  title: Text(medication.title),
                  subtitle: Text(medication.description),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  dayView() {
    return BlocBuilder<MedicationBloc, MedicationState>(
      builder: (context, state) {
        if (state is MedicationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MedicationFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is MedicationSuccess) {
          return Expanded(
            child: ListView.builder(
              itemCount: bloc.medications.length,
              itemBuilder: (context, index) {
                final medication = bloc.medications[index];
                return ListTile(
                  title: Text(medication.title),
                  subtitle: Text(medication.description),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  monthView() {
    return BlocBuilder<MedicationBloc, MedicationState>(
      builder: (context, state) {
        if (state is MedicationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MedicationFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is MedicationSuccess) {
          return Expanded(
            child: ListView.builder(
              itemCount: bloc.medications.length,
              itemBuilder: (context, index) {
                final medication = bloc.medications[index];
                return ListTile(
                  title: Text(medication.title),
                  subtitle: Text(medication.description),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
