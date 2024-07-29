import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class GarageView extends ConsumerStatefulWidget {
  const GarageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GarageViewState();
}

class _GarageViewState extends ConsumerState<GarageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: "Garage View".txt18(),
      ),
    );
  }
}
