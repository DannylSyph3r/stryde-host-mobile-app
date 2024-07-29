import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class MessagesView extends ConsumerStatefulWidget {
  const MessagesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagesViewState();
}

class _MessagesViewState extends ConsumerState<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: "Messages View".txt18(),
    ));
  }
}