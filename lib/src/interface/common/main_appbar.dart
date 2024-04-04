import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/interface/home/widgets/widgets.dart';
import 'package:sweet_chores/src/widgets/stroke_text.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    required this.openDrawer,
  });

  final void Function() openDrawer;

  @override
  Size get preferredSize => const Size.fromHeight(60);
  double get sizeIcons => 30;
  @override
  Widget build(BuildContext context) {
    final FilterTime statusFilter =
        context.watch<SweetChoresNotesBloc>().state.filterStatus;
    return AppBar(
      shadowColor: null,
      leading: IconButton(
        icon: Icon(
          semanticLabel: 'App menú',
          Icons.menu_rounded,
          weight: 40,
          color: Colors.white,
          size: sizeIcons,
        ),
        onPressed: openDrawer,
      ),
      actions: [
        IconButton(
            onPressed: () =>
                showFilterDialog(context, lastFilter: statusFilter),
            icon: Icon(
              semanticLabel: 'filter to-do',
              Icons.tune_rounded,
              color: Colors.white,
              size: sizeIcons,
            )),
      ],
      title: StrokeText(
        text: 'Sweet Chores',
        strokeWidth: 4,
        letterSpacing: 2,
        textSize: 30,
        strokeColor: Theme.of(context).colorScheme.secondary,
      ),
      centerTitle: true,
    );
  }
}
