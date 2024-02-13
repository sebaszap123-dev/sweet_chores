import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/blocs/blocs.dart';
import 'package:sweet_chores/src/models/models.dart';

class EditChoresDialog extends StatefulWidget {
  final Todo todo;

  const EditChoresDialog({Key? key, required this.todo}) : super(key: key);

  @override
  EditChoresDialogState createState() => EditChoresDialogState();
}

class EditChoresDialogState extends State<EditChoresDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController =
        TextEditingController(text: widget.todo.description);
    selectedDate = widget.todo.dueDate != null
        ? DateTime.fromMillisecondsSinceEpoch(widget.todo.dueDate!)
        : null;
    selectedTime =
        selectedDate != null ? TimeOfDay.fromDateTime(selectedDate!) : null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.edit),
          SizedBox(width: 8),
          Text('Edit'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: ThemeDecorations.kawaiBorder(
              context: context,
              // color: Colors.white,
              label: 'Title',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: ThemeDecorations.kawaiBorder(
              context: context,
              // color: Colors.white,
              label: 'Description',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              Text(
                selectedDate != null
                    ? DateFormat('MMM dd, yyyy').format(selectedDate!)
                    : 'Select Date',
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _selectDate(context),
                child: const Text('Choose Date'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 8),
              Text(
                selectedTime != null
                    ? selectedTime!.format(context)
                    : 'Select Time',
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _selectTime(context),
                child: const Text('Choose Time'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cancelar
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Aplicar cambios y regresar el Todo editado
            final editedTodo = widget.todo.copyWith(
              title: titleController.text,
              description: descriptionController.text.isNotEmpty
                  ? descriptionController.text
                  : widget.todo.description,
              dueDate: selectedDate != null
                  ? DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedTime?.hour ?? 0,
                          selectedTime?.minute ?? 0)
                      .millisecondsSinceEpoch
                  : null,
              hasTime: selectedTime != null,
            );
            Navigator.of(context).pop(editedTodo);
          },
          child: const Text('Apply Changes'),
        ),
      ],
    );
  }
}

Future<void> showEditTodoDialog(BuildContext context,
    {required Todo todo}) async {
  final resp = await showDialog<Todo>(
    barrierDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return EditChoresDialog(todo: todo);
    },
  );
  if (resp != null) {
    // ignore: use_build_context_synchronously
    context.read<SweetChoresNotesBloc>().add(EditChoresEvent(resp));
  }
}
