import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';
import 'package:timecounter/main.dart';
import 'package:timecounter/string_time_interval.dart';

class IntervalInput extends StatelessWidget {
  final startController = TextEditingController();
  final endController = TextEditingController();

  void addInterval() {
    try {
      final interval = StringTimeInterval(start: startController.text, end: endController.text);
      if (interval.dateTimeRange == null) return;
      final items = appController.items.valueWrapper?.value ?? [];
      appController.items.add(items + [interval]);
      startController.clear();
      endController.clear();
    } catch (e, s) {
      clog(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(border: OutlineInputBorder());
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 4, bottom: 8),
            child: TextFormField(
              controller: startController,
              decoration: decoration.copyWith(labelText: 'Start'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 4, bottom: 8),
            child: TextFormField(
              controller: endController,
              decoration: decoration.copyWith(labelText: 'End'),
            ),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          child: Icon(Icons.add),
          onPressed: addInterval,
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
