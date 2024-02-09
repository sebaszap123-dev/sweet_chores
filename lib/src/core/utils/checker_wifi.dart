// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/interface/common/no_wifi.dart';

/// Show a notification to the user
Future<bool> checkInternetState(
    GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) async {
  final isConnected = await getIt<NetworkInfo>().isConnected();
  if (!isConnected) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.primary,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const NoWifi(),
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  return isConnected;
}
