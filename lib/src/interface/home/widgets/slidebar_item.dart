import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/blocs.dart';
import 'package:sweet_chores_reloaded/src/models/models.dart';

class SlidebarItem extends StatefulWidget {
  const SlidebarItem({
    super.key,
    this.selectedState,
    this.isEditing = false,
    required this.category,
  });
  final Categories category;
  final void Function(bool)? selectedState;
  final bool isEditing;
  @override
  State<SlidebarItem> createState() => _SlidebarItemState();
}

class _SlidebarItemState extends State<SlidebarItem> {
  bool isSelected = true;
  _goToCategory(Categories category) {
    context.router.push(CategoriesManagerRoute(category: category));
  }

  @override
  void initState() {
    isSelected = widget.category.isActive;
    super.initState();
  }

  Future<void> _showDeleteCategoryDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete this category?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<CategoriesBloc>()
                    .add(RemoveCategory(widget.category));
                context.router.pop();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          leading: widget.isEditing
              ? customWarningIcon()
              : Icon(
                  widget.category.iconData ?? Icons.circle,
                  size: 22,
                  color: widget.category.color,
                ),
          title: Text(
            widget.category.name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: widget.isEditing
              ? null
              : () => setState(() {
                    isSelected = !isSelected;
                    widget.category.isActive = !isSelected;
                    if (widget.selectedState != null) {
                      widget.selectedState!(isSelected);
                    }
                  }),
          trailing: widget.isEditing
              ? IconButton(
                  onPressed: () => _goToCategory(widget.category),
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ))
              : isSelected
                  ? Icon(Icons.check_circle,
                      color: Theme.of(context).colorScheme.secondary)
                  : null,
        ),
        Divider(
            color: context
                .watch<SweetPreferencesBloc>()
                .state
                .themeColors
                .text
                .withOpacity(0.3)),
      ],
    );
  }

  Widget customWarningIcon() {
    const double size = 24;
    return GestureDetector(
      onTap: () => _showDeleteCategoryDialog(),
      child: Container(
        width: size,
        height: size,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Divider(
              color: Colors.white, // Color de la línea
              thickness: 1.0, // Grosor de la línea
            ),
          ),
        ),
      ),
    );
  }
}
