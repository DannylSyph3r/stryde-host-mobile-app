import 'package:flutter_riverpod/flutter_riverpod.dart';

final carouselStateProvider = StateProvider<int>((ref) => 0);
final idTypeSelectionProvider = StateProvider<String>((ref) => "");
