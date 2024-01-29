import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

@RoutePage()
class BackUpScreen extends StatelessWidget {
  const BackUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => getIt<SweetRouterCubit>().state.pop(),
        ),
        title: const Text('Backup', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              // TODO: ADD FUNCTION BACKUP DATABASE
              onPressed: () {},
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 8,
                    child: Icon(
                      Icons.cloud_circle_rounded,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  const Spacer(flex: 1),
                  const Flexible(
                    flex: 8,
                    child: Text('Make a backup',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 8,
                    child: Icon(
                      Icons.cloud_circle_rounded,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  const Spacer(flex: 1),
                  const Flexible(
                    flex: 8,
                    child: Text('Restore a backup',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
