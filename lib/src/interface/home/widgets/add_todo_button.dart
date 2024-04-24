import 'package:flutter/material.dart';
import 'package:sweet_chores/src/interface/home/widgets/add_todo_dialog.dart';
import 'package:sweet_chores/src/interface/home/widgets/widgets.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showAddTodoDialog(context),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.add,
        color: Colors.white,
        semanticLabel: 'Add Todo',
        shadows: [
          Shadow(
            color: Theme.of(context).colorScheme.secondary,
            blurRadius: 15,
            offset: Offset.fromDirection(0, 0),
          )
        ],
      ),
    );
  }

  // TODO-FEATURE-IOS: use for IOS VERSION
  // ignore: unused_element
  Future<dynamic> _modalIOSAddTodo(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.915,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          boxShadow: const [],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: const BottomSheetModal(),
      ),
    );
  }
}
