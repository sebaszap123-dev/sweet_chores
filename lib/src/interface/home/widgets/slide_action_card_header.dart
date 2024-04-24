import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/helpers.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/models/models.dart';

class SlideActionCardHeader extends StatelessWidget {
  const SlideActionCardHeader({
    Key? key,
    required this.todo,
    required this.index,
    required this.category,
    required this.removeTodo,
    required this.alterTodo,
    required this.editTodo,
    this.enableDescription = true,
    this.isOverDue = false,
  }) : super(key: key);

  final Todo todo;
  final int index;
  final Categories category;
  final void Function(Todo) removeTodo;
  final void Function(Todo) alterTodo;
  final void Function() editTodo;
  final bool enableDescription;
  final bool isOverDue;

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .secondary, // Use your desired color
              label: 'Edit',
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          titleAlignment: ListTileTitleAlignment.center,
          leading: Icon(
            Icons.circle,
            color: category.color,
            size: 30,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              if (isOverDue)
                const Icon(
                  Icons.flag_circle_outlined,
                  color: Colors.red,
                ),
            ],
          ),
          isThreeLine: todo.dueDate != null &&
              (todo.description != null && todo.description!.isNotEmpty),
          subtitle: !_validated
              ? null
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    enableDescription &&
                            todo.description != null &&
                            todo.description!.isNotEmpty
                        ? Text(
                            todo.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox(height: 5),
                    if (todo.dueDate != null)
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: context
                                .watch<SweetPreferencesBloc>()
                                .state
                                .themeColors
                                .text,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            parseDueDate(todo.dueDate!, hasTime: todo.hasTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 16,
                                    color: context
                                        .watch<SweetPreferencesBloc>()
                                        .state
                                        .themeColors
                                        .text),
                          ),
                        ],
                      )
                  ],
                ),
          trailing: _CheckBox(
            active: todo.isDone,
            onTap: () => alterTodo(todo),
          ),
        ),
      ),
    );
  }

  bool get _validated {
    return todo.dueDate != null ||
        (todo.description != null && todo.description!.isNotEmpty);
  }
}

class _CheckBox extends StatelessWidget {
  const _CheckBox({
    required this.active,
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
