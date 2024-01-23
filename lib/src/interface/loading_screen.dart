import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/interface/common/common.dart';

@RoutePage()
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Loading());
  }
}
