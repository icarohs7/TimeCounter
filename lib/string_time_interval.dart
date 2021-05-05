import 'package:core_resources/core_resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'string_time_interval.freezed.dart';
part 'string_time_interval.g.dart';

@freezed
class StringTimeInterval with _$StringTimeInterval {
  const factory StringTimeInterval({
    required String start,
    required String end,
  }) = _StringTimeInterval;

  const StringTimeInterval._();

  DateTimeRange? get dateTimeRange {
    final startParts = start.split(':');
    final endParts = end.split(':');

    if (startParts.length != 2 && endParts.length != 2) return null;

    final startHour = startParts[0].toIntOrNull();
    final startMinute = startParts[1].toIntOrNull();

    final endHour = endParts[0].toIntOrNull();
    final endMinute = endParts[1].toIntOrNull();

    if (startHour == null || startMinute == null || endHour == null || endMinute == null)
      return null;

    final now = DateTime.now();
    return DateTimeRange(
      start: DateTime(now.year, now.month, now.day, startHour, startMinute),
      end: DateTime(now.year, now.month, now.day, endHour, endMinute),
    );
  }

  factory StringTimeInterval.fromJson(Map<String, dynamic> json) =>
      _$StringTimeIntervalFromJson(json);
}
