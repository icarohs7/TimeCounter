import 'package:rxdart/rxdart.dart';
import 'package:timecounter/string_time_interval.dart';

class AppController {
  // ignore: close_sinks
  final items = BehaviorSubject.seeded(<StringTimeInterval>[]);
}
