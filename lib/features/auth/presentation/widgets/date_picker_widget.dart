// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/tools/tools.dart';
import '../bloc/auth_bloc.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final AuthBloc bloc;
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: TextField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: t.dateOfBirth,
            hintText: widget.bloc.selectedDate != null
                ? DateFormat('dd/MM/yyyy').format(widget.bloc.selectedDate!)
                : 'dd/mm/yyyy',
            suffixIcon: IconButton(
              onPressed: () async {
                widget.bloc.selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2007));
                setState(() {});
              },
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
