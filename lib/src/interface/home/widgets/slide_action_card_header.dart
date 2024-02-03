import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/helpers.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/models/models.dart';

class SlideActionCardHeader extends StatelessWidget {
  const SlideActionCardHeader({
    super.key,
    required this.todo,
    required this.index,
    required this.category,
    required this.removeTodo,
    required this.alterTodo,
    this.enableDescription = true,
    this.isOverDue = false,
    required this.editTodo,
  });

  final Todo todo;
  final int index;
  final Categories category;
  final void Function(Todo) removeTodo;
  final void Function(int) alterTodo;
  final void Function() editTodo;
  final bool enableDescription;
  final bool isOverDue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.zero,
      color: !isOverDue
          ? Theme.of(context).cardTheme.color
          : context.watch<SweetPreferencesBloc>().state.themeColors.overDue,
      shadowColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Slidable(
        key: ValueKey(index),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              onPressed: (_) => removeTodo(todo),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              onPressed: (_) => editTodo(),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              label: 'Edit',
            ),
          ],
        ),
        child: SizedBox(
          width: size.width,
          height: size.height * 0.12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 20,
                left: 15,
                child: Icon(
                  Icons.circle,
                  color: category.color,
                  size: 20,
                ),
              ),
              Positioned(
                top: 18,
                left: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            todo.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 20),
                          ),
                        ),
                        if (isOverDue)
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ),
                      ],
                    ),
                    _spacer(),
                    if (enableDescription)
                      todo.description != null
                          ? SizedBox(
                              width: size.width * 0.69,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  todo.description!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          : Container(),
                    _spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: todo.dueDate != null
                          ? Text(
                              'Due: ${parseDueDate(todo.dueDate, hasTime: todo.hasTime)!}',
                            )
                          : const Text('Due: when your desire!'),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 15,
                child: _CheckBox(
                  active: todo.isDone,
                  onTap: () => alterTodo(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({
    this.active = false,
    required this.onTap,
  });

  final bool active;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              !active ? Colors.white : Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
        ),
        child: active
            ? const Icon(
                Icons.done_rounded,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

Widget _spacer() {
  return const SizedBox(
    height: 5,
  );
}
