import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    super.key,
    required this.cn,
    required this.label,
    this.type,
    this.width,
  });
  final TextEditingController cn;
  final String label;
  final TextInputType? type;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: TextField(
            controller: cn,
            keyboardType: type,
            decoration: InputDecoration(
              labelText: label,
              hintText: label,
            ),
          ),
        ),
      ),
    );
  }
}
