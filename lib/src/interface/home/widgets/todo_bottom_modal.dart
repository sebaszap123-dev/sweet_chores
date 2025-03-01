import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/models/models.dart';

import 'date_time_picker/sweet_due_date_picker.dart';

// FOR IOS VERSION (TODO-MODAL-ADD)

class BottomSheetModal extends StatefulWidget {
  const BottomSheetModal({super.key});

  @override
  State<BottomSheetModal> createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal> {
  TextEditingController taskTitleController = TextEditingController(text: '');
  TextEditingController taskTextController = TextEditingController(text: '');
  Categories? selectedCategory;
  DateTime? dueDate;

  void _addDueDate(DateTime? value) {
    setState(() {
      dueDate = value;
    });
  }

  void _addTodo(Todo todo) {
    context.read<SweetChoresNotesBloc>().add(AddChoresEvent(todo));
  }

  final EdgeInsets paddingFields = const EdgeInsets.symmetric(vertical: 10);

  @override
  Widget build(BuildContext context) {
    final categoryBloc = context.watch<SweetChoresNotesBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 28,
                ),
                onPressed: () => context.router.pop(),
              ),
              title: const Text(
                'New note',
                textAlign: TextAlign.center,
              ),
              trailing: TextButton(
                onPressed: () => _onAdd(categoryBloc),
                child: Text(
                  'Done',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: paddingFields,
              child: TextField(
                controller: taskTitleController,
                decoration: ThemeDecorations.kawaiBorder(
                  context: context,
                  hintext: 'Write your next amazing activity!',
                  label: 'Title',
                ),
              ),
            ),
            Padding(
              padding: paddingFields,
              child: TextField(
                controller: taskTextController,
                decoration: ThemeDecorations.kawaiBorder(
                  context: context,
                  label: 'Note',
                ),
              ),
            ),
            SweetDueDatePicker(
              onChangeDate: _addDueDate,
            ),
            const SizedBox(height: 10),
            _chooseListWidget(categoryBloc),
          ],
        ),
      ),
    );
  }

  // TODO-FEATURE-IOS: CHANGE THIS WITH DESIGN FOR IOS
  Widget _chooseListWidget(SweetChoresNotesBloc categoryBloc) {
    return ListTile(
      leading: Icon(
        selectedCategory?.iconData ??
            (categoryBloc.state.categories.isEmpty
                ? Icons.add_rounded
                : categoryBloc.state.categories.first.iconData),
        color: selectedCategory?.color ??
            categoryBloc.state.categories.first.color,
      ),
      minLeadingWidth: 185,
      title: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
        ),
        child: DropdownButton<Categories>(
          underline: Container(),
          borderRadius: BorderRadius.circular(12),
          padding: const EdgeInsets.only(left: 10),
          isExpanded: false,
          value: selectedCategory ??
              (categoryBloc.state.categories.isEmpty
                  ? Categories(
                      name: 'add category', id: 0, iconData: Icons.add_rounded)
                  : categoryBloc.state.categories.first),
          items: categoryBloc.state.categories
              .map((category) => DropdownMenuItem<Categories>(
                  value: category, child: Text(category.name)))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
        ),
      ),
    );
  }

  void _onAdd(SweetChoresNotesBloc categoryBloc) {
    if (taskTitleController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Please add a title for the note',
                  textAlign: TextAlign.center),
              icon: Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
            );
          });
      return;
    }
    _addTodo(
      Todo(
        title: taskTitleController.text,
        description:
            taskTextController.text.isEmpty ? null : taskTextController.text,
        categoryID:
            selectedCategory?.id ?? categoryBloc.state.categories.first.id,
        dueDate: dueDate?.millisecondsSinceEpoch,
      ),
    );
    taskTitleController.clear();
    taskTextController.clear();
    context.router.pop();
  }
}
