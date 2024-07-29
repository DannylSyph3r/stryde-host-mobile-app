import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final focusedDayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

