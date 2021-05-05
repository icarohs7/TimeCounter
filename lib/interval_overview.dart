import 'package:core_resources/core_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:timecounter/main.dart';
import 'package:timecounter/string_time_interval.dart';

class IntervalOverview extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final intervals = useStream(
      appController.items,
      initialData: appController.items.valueWrapper?.value ?? [],
    );
    final items = intervals.data ?? [];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (ctx, idx) {
              return _IntervalItem(
                idx,
                items[idx],
                onDismissed: () {
                  try {
                    final newList = List<StringTimeInterval>.from(items);
                    newList.removeAt(idx);
                    appController.items.add(newList);
                  } catch (e, s) {
                    clog(s);
                  }
                },
              );
            },
          ),
        ),
        if (items.isNotEmpty) Expanded(child: _ItemsOverview(items)),
      ],
    );
  }
}

class _IntervalItem extends StatelessWidget {
  const _IntervalItem(
    this.index,
    this.item, {
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  final int index;
  final StringTimeInterval item;
  final void Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    if (item.dateTimeRange == null) return SizedBox();
    final range = item.dateTimeRange!;
    final start = range.start;
    final end = range.end;

    final duration = range.duration.abs();
    final minutes = duration.inMinutes % 60;
    final hours = duration.inMinutes ~/ 60;

    return DismissibleFromEndToStart(
      itemKey: ValueKey(index),
      onDismissed: onDismissed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
        child: Text(
          '${start.hour.toString().padLeft(2, '0')}:'
          '${start.minute.toString().padLeft(2, '0')} ~ '
          '${end.hour.toString().padLeft(2, '0')}:'
          '${end.minute.toString().padLeft(2, '0')}      - '
          '${hours > 0 ? '$hours Hours and ' : ''}$minutes minutes',
        ),
      ),
    );
  }
}

class _ItemsOverview extends StatelessWidget {
  const _ItemsOverview(this.items, {Key? key}) : super(key: key);
  final List<StringTimeInterval> items;

  @override
  Widget build(BuildContext context) {
    final ranges = items.mapNotNull((e) => e.dateTimeRange);
    final totalTime = ranges.fold<Duration>(Duration.zero, (acc, e) {
      return acc + e.start.difference(e.end);
    }).abs();

    final minutes = totalTime.inMinutes % 60;
    final hours = totalTime.inMinutes ~/ 60;
    return Column(
      children: [
        ListTile(title: Text('$hours Hours and $minutes minutes')),
        ListTile(title: Text('${(hours + (minutes / 60)).toStringAsPrecision(3)} Hours (decimal)')),
      ],
    );
  }
}
