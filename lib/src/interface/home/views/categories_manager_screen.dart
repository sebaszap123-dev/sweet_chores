import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/data/blocs/blocs.dart';
import 'package:sweet_chores/src/models/categories.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CategoriesManagerScreen extends StatefulWidget {
  const CategoriesManagerScreen({
    super.key,
    this.category,
  });
  final Categories? category;

  @override
  State<CategoriesManagerScreen> createState() =>
      _CategoriesManagerScreenState();
}

class _CategoriesManagerScreenState extends State<CategoriesManagerScreen> {
  IconData? selectedIcon;
  Color selectedColor = Colors.black87;
  final double radius = 8;
  _manageCategory(Categories category) {
    if (widget.category != null) {
      final updated = category.copyWith(id: widget.category!.id);
      _alterCategory(updated);
    } else {
      _addCategory(category);
    }
  }

  _addCategory(Categories category) {
    if (textController.text.isNotEmpty) {
      context.read<SweetChoresNotesBloc>().add(AddCategoryEvent(category));
      context.router.pop(category);
    }
  }

  _alterCategory(Categories category) {
    if (textController.text.isNotEmpty) {
      context.read<SweetChoresNotesBloc>().add(AlterCategoryEvent(category));
      context.router.replace(const HomeRoute());
    }
  }

  final textController = TextEditingController();
  final cardExpandable = ExpandableController(initialExpanded: false);

  @override
  void initState() {
    textController.text = widget.category?.name ?? '';
    selectedIcon = widget.category?.iconData;
    selectedColor = widget.category?.color ?? Colors.black87;
    cardExpandable.addListener(() {
      if (cardExpandable.expanded && mounted) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cardExpandable.removeListener(() {});
    cardExpandable.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => context.router.pop(),
        ),
        actions: [
          TextButton(
              onPressed: () => _manageCategory(Categories(
                    name: textController.text,
                    color: selectedColor,
                    iconData: selectedIcon,
                  )),
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            TextField(
              onTap: () =>
                  cardExpandable.expanded ? cardExpandable.toggle() : null,
              controller: textController,
              decoration: ThemeDecorations.kawaiBorderIcon(
                context: context,
                color: Colors.white,
                icon: selectedIcon == null && selectedColor != Colors.black87
                    ? Icons.circle
                    : selectedIcon,
                iconColor: selectedColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius),
              ),
              height: MediaQuery.of(context).size.height * 0.15,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8),
                itemCount: sweetIconColors.length,
                itemBuilder: (context, index) => IconButton(
                  icon: Icon(
                    Icons.circle,
                    color: sweetIconColors[index],
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedColor = sweetIconColors[index];
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            // * ICONS
            ExpandableNotifier(
                controller: cardExpandable,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.white,
                  child: ExpandablePanel(
                    collapsed: Container(
                      padding: EdgeInsets.zero,
                    ),
                    header: Container(
                      height: 60,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Icon',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 22),
                      ),
                    ),
                    expanded: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8),
                          itemCount: SweetChores.sweetChoresIconsList.length,
                          itemBuilder: (context, index) => IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIcon =
                                        SweetChores.sweetChoresIconsList[index];
                                  });
                                },
                                icon: Icon(
                                  SweetChores.sweetChoresIconsList[index],
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
