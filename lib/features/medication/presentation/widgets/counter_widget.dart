import 'package:flutter/material.dart';

import '../../../../core/tools/tools.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget(
      {super.key,
      required this.pillCount,
      required this.onDecreas,
      required this.onIncrease,
      required this.title});
  final int pillCount;
  final VoidCallback onDecreas;
  final VoidCallback onIncrease;
  final String title;
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: widget.onDecreas,
            icon: const Icon(Icons.remove, color: Colors.white)),
        Text(
          t.pill(widget.title, widget.pillCount),
          style: txtTheme(context).bodyLarge!.copyWith(color: Colors.white),
        ),
        IconButton(
            onPressed: widget.onIncrease,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ],
    );
  }
}
