import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/data_source.dart';

class NoWifi extends StatelessWidget {
  const NoWifi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 80,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, color: Colors.white, size: 35),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                "Sorry, you're currently offline. Please try again later.",
                style: TextStyle(
                  color: context
                      .watch<SweetPreferencesBloc>()
                      .state
                      .themeColors
                      .text,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
