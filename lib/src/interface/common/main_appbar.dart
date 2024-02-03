import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/interface/home/widgets/widgets.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    required this.openDrawer,
  });

  final void Function() openDrawer;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final FilterStatus statusFilter =
        context.watch<TodoBloc>().state.filterStatus;
    return AppBar(
      shadowColor: null,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: openDrawer,
      ),
      actions: [
        IconButton(
            onPressed: () =>
                showFilterDialog(context, lastFilter: statusFilter),
            icon: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
            )),
      ],
      title: const Text(
        'Sweet Chores',
        style: TextStyle(
          color: Colors.white,
          fontSize: 27,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }
}
