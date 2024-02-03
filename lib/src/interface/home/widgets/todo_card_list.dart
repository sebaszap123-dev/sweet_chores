import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/interface/common/common.dart';
import 'package:sweet_chores/src/models/todo.dart';

class TodoCardList extends StatefulWidget {
  const TodoCardList(
      {super.key,
      required this.todos,
      required this.status,
      this.isEmpty = false});
  final List<Todo> todos;
  final FilterStatus status;
  final bool isEmpty;
  @override
  State<TodoCardList> createState() => _TodoCardListState();
}

class _TodoCardListState extends State<TodoCardList> {
  void removeTodo(Todo todo) {
    getIt<TodoBloc>().add(RemoveTodo(todo));
  }

  void alterTodo(int index) {
    getIt<TodoBloc>().add(AlterTodo(index));
  }

  List<bool> isOpen = [];
  @override
  Widget build(BuildContext context) {
    isOpen = isOpen.isEmpty
        ? List.generate(widget.todos.length, (index) => false)
        : isOpen;

    return !widget.isEmpty
        ? ListView(
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            children: [
              ...widget.todos.asMap().entries.map(
                (entry) {
                  return TodoExpansionCard(
                    alterTodo: alterTodo,
                    category: context
                        .watch<CategoriesBloc>()
                        .state
                        .getCategory(entry.value.categoryID),
                    index: entry.key,
                    removeTodo: removeTodo,
                    todo: entry.value,
                  );
                },
              ),
            ],
          )
        : EmptyStateWidget(
            status: widget.status,
          );
  }
}
