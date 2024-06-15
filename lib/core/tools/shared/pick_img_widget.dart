import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../tools.dart';

class PickDocWidget extends StatefulWidget {
  const PickDocWidget({super.key, required this.path});
  final String path;
  @override
  State<PickDocWidget> createState() => _PickDocWidgetState();
}

class _PickDocWidgetState extends State<PickDocWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.path.isEmpty
        ? empty
        : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(
              File(widget.path),
              fit: BoxFit.cover,
              width: 50.w,
            ),
          );
  }
}
