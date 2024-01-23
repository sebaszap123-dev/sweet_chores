import '../../../models/todo.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sweet_chores_reloaded/src/config/themes/themes.dart';
import 'package:sweet_chores_reloaded/src/core/utils/helpers.dart';
import 'package:sweet_chores_reloaded/src/interface/home/widgets/edit_todo_dialog.dart';
import 'package:sweet_chores_reloaded/src/interface/home/widgets/widgets.dart';
import 'package:sweet_chores_reloaded/src/models/categories.dart';

class TodoExpansionCard extends StatefulWidget {
  const TodoExpansionCard({
    super.key,
    required this.todo,
    required this.index,
    required this.category,
    required this.removeTodo,
    required this.alterTodo,
  });
  final Todo todo;
  final int index;
  final Categories category;
  final void Function(Todo) removeTodo;
  final void Function(int) alterTodo;

  @override
  State<TodoExpansionCard> createState() => _TodoExpansionCardState();
}

class _TodoExpansionCardState extends State<TodoExpansionCard> {
  final controller = ExpandableController();
  bool enableDescription = true;
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        enableDescription = !controller.value;
      });
    });
    super.initState();
  }

  bool _enableExpandedCard() {
    return widget.todo.description == null
        ? false
        : widget.todo.description!.length > 20
            ? true
            : false;
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.zero,
              color: !isOverDue(widget.todo)
                  ? Theme.of(context).colorScheme.primary
                  : SweetBoyThemeColors.overDue.withOpacity(0.36),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ExpandablePanel(
                    theme: ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: _enableExpandedCard(),
                      tapBodyToCollapse: _enableExpandedCard(),
                      tapHeaderToExpand: _enableExpandedCard(),
                      hasIcon: false,
                    ),
                    header: SlideActionCardHeader(
                      alterTodo: widget.alterTodo,
                      category: widget.category,
                      index: widget.index,
                      removeTodo: widget.removeTodo,
                      todo: widget.todo,
                      enableDescription: enableDescription,
                      editTodo: () =>
                          showEditTodoDialog(context, todo: widget.todo),
                      isOverDue: isOverDue(widget.todo),
                    ),
                    collapsed: Container(),
                    expanded: TodoCardBody(
                      miniTask: [widget.todo.description ?? ''],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
