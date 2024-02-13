import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sweet_chores/src/config/router/sweet_router.dart';
import 'package:sweet_chores/src/config/router/sweet_router.gr.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/blocs/blocs.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/models/models.dart';

/// Dialog for android version of the app
class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  AddTodoDialogState createState() => AddTodoDialogState();
}

class AddTodoDialogState extends State<AddTodoDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Categories? currentCategory;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    currentCategory =
        context.read<SweetChoresNotesBloc>().state.categories.isNotEmpty
            ? context.read<SweetChoresNotesBloc>().state.categories.first
            : null;
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

  bool get _validateForm {
    return formKey.currentState?.validate() ?? false;
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(Icons.add_rounded, size: 30),
          Text(
            'Add chore',
            style: GoogleFonts.spicyRice().copyWith(
              color: getIt<SweetPreferencesBloc>().state.themeColors.primary,
              fontSize: 28,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: titleController,
                validator:
                    RequiredValidator(errorText: 'This field is required'),
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
              const SizedBox(height: 5),
              Text('Select your list',
                  style: GoogleFonts.roboto().copyWith(
                    color: getIt<SweetPreferencesBloc>()
                        .state
                        .themeColors
                        .secondary,
                    fontSize: 18,
                  )),
              const SizedBox(height: 5),
              BlocBuilder<SweetChoresNotesBloc, SweetChoresNotesState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<Categories>(
                        value: currentCategory,
                        padding: EdgeInsets.zero,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(12),
                        dropdownColor: Theme.of(context).colorScheme.primary,
                        items: state.categories.isNotEmpty
                            ? state.categories
                                .map((e) => DropdownMenuItem<Categories>(
                                      value: e,
                                      child: Text(e.name),
                                    ))
                                .toList()
                            : [],
                        onChanged: (category) {
                          if (category != null) {
                            setState(() {
                              currentCategory = category;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () => getIt<SweetRouterCubit>().state.push(
                              CategoriesManagerRoute(),
                            ),
                        icon:
                            const Icon(Icons.add_rounded, color: Colors.white),
                        label: const Text(
                          "Add new category",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
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
            if (!_validateForm) return;
            if (currentCategory == null) {
              SweetDialogs.alertInfo(
                  info:
                      'Before proceeding, please make sure to add a category for your entry.',
                  title: 'Oops! Looks like something is missing.');
            } else {
              final newTodo = Todo(
                title: titleController.text,
                categoryID: currentCategory!.id,
                description: descriptionController.text,
                dueDate: selectedDate?.millisecondsSinceEpoch,
                hasTime: selectedTime != null,
              );
              getIt<SweetRouterCubit>().state.pop(newTodo);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

Future<void> showAddTodoDialog(BuildContext context) async {
  final resp = await showDialog<Todo>(
    barrierDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return const AddTodoDialog();
    },
  );
  if (resp != null) {
    // ignore: use_build_context_synchronously
    context.read<SweetChoresNotesBloc>().add(AddChoresEvent(resp));
  }
}
