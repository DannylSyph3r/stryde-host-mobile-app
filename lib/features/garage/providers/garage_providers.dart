import 'package:flutter_riverpod/flutter_riverpod.dart';

final kycGarageProvider = StateProvider<bool>((ref) {
  return false;
});

final garageListProvider = StateProvider<int>((ref) {
  return 0;
});

