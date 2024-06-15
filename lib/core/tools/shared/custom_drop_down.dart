import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.value,
      required this.list,
      required this.onChange});
  final String value;
  final List list;
  final Function(String?) onChange;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10),
        child: DropdownButton(
          hint: Text(value),
          isExpanded: true,
          items: list
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e['id'],
                  child: Text(
                    e['value'],
                  ),
                ),
              )
              .toList(),
          onChanged: onChange,
        ),
      ),
    );
  }
}
