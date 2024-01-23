import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/core/app_export.dart';
import 'package:sweet_chores_reloaded/src/interface/home/widgets/widgets.dart';

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    required this.openDrawer,
  });

  final void Function() openDrawer;

  @override
  State<MainAppbar> createState() => _MainAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _MainAppbarState extends State<MainAppbar> {
  FilterStatus statusFilter = FilterStatus.all;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: null,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: widget.openDrawer,
      ),
      actions: [
        BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            statusFilter = state.filterStatus;
          },
          child: IconButton(
              onPressed: () =>
                  showFilterDialog(context, lastFilter: statusFilter),
              icon: const Icon(
                Icons.tune_rounded,
                color: Colors.white,
              )),
        )
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
