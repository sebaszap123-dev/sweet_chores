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
      getIt<SweetChoresNotesBloc>().add(const DateChoresEvent(true));
    }
  }

  Color? get textButtonColor {
    if (context.watch<SweetPreferencesBloc>().state.isDarkMode) {
      return Colors.white;
    }
    return null;
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
              color: context
                  .watch<SweetPreferencesBloc>()
                  .state
                  .themeColors
                  .primary,
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
                  label: 'Title',
                  isDarkMode:
                      context.read<SweetPreferencesBloc>().state.isDarkMode,
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    maxHeight: 300, maxWidth: double.infinity, minWidth: 150),
                child: TextField(
                  controller: descriptionController,
                  maxLines: null,
                  decoration: ThemeDecorations.kawaiBorder(
                    context: context,
                    label: 'Description',
                    isDarkMode:
                        context.read<SweetPreferencesBloc>().state.isDarkMode,
                  ),
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
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: textButtonColor ??
                              context
                                  .read<SweetPreferencesBloc>()
                                  .state
                                  .themeColors
                                  .grayly),
                    ),
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
                    child: Text(
                      'Choose Time',
                      style: TextStyle(
                          color: textButtonColor ??
                              context
                                  .read<SweetPreferencesBloc>()
                                  .state
                                  .themeColors
                                  .grayly),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text('Select your list',
                  style: GoogleFonts.roboto().copyWith(
                    color: textButtonColor ??
                        context
                            .read<SweetPreferencesBloc>()
                            .state
                            .themeColors
                            .grayly,
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
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                            color: textButtonColor ??
                                                context
                                                    .read<
                                                        SweetPreferencesBloc>()
                                                    .state
                                                    .themeColors
                                                    .grayly),
                                      ),
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
                        icon: Icon(Icons.add_rounded,
                            color: textButtonColor ?? Colors.black),
                        label: Text(
                          "Add new category",
                          style:
                              TextStyle(color: textButtonColor ?? Colors.black),
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
          child: Text('Cancel',
              style: TextStyle(
                color: textButtonColor ??
                    context
                        .read<SweetPreferencesBloc>()
                        .state
                        .themeColors
                        .grayly,
              )),
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
              final date = myDateTime(date: selectedDate, time: selectedTime);
              final newTodo = Todo(
                title: titleController.text,
                categoryID: currentCategory!.id,
                description: descriptionController.text,
                dueDate: date?.millisecondsSinceEpoch,
                hasTime: selectedTime != null,
              );
              getIt<SweetRouterCubit>().state.pop(newTodo);
            }
          },
          child: Text('Add',
              style: TextStyle(
                color: textButtonColor ??
                    context
                        .read<SweetPreferencesBloc>()
                        .state
                        .themeColors
                        .grayly,
              )),
        ),
      ],
    );
  }
}

DateTime? myDateTime({DateTime? date, TimeOfDay? time}) {
  if (date != null && time != null) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  } else if (date != null && time == null) {
    return date;
  } else if (time != null && date == null) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  } else {
    return null;
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
