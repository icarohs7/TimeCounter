import 'package:rxdart/rxdart.dart';
import 'package:timecounter/string_time_interval.dart';

class AppController {
  final items = BehaviorSubject.seeded(<StringTimeInterval>[]); // ignore: close_sinks

  final multiplier = BehaviorSubject<double>(); // ignore: close_sinks
}
