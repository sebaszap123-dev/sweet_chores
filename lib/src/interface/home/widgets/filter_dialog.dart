import 'package:flutter/material.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/data_source.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key, required this.selectedFilter});

  @override
  FilterDialogState createState() => FilterDialogState();

  final FilterStatus selectedFilter;
}

class FilterDialogState extends State<FilterDialog> {
  late FilterStatus selectedFilter;

  @override
  void initState() {
    selectedFilter = widget.selectedFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        'Filter chores',
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterRadio(
                FilterStatus.all, 'All', Icons.calendar_today), // Agrega icono
            _buildFilterRadio(FilterStatus.today, 'Today', Icons.today),
            _buildFilterRadio(
                FilterStatus.week, 'This week', Icons.calendar_month),
            _buildFilterRadio(
                FilterStatus.month, 'This Month', Icons.date_range),
            _buildFilterRadio(
                FilterStatus.overDue, 'Overdue', Icons.warning_amber),
            _buildFilterRadio(FilterStatus.done, 'Done', Icons.check_circle),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedFilter);
          },
          child: Text(
            'Apply',
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRadio(FilterStatus filter, String label, IconData icon) {
    return RadioListTile<FilterStatus>(
      title: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
        ],
      ),
      value: filter,
      groupValue: selectedFilter,
      activeColor: Theme.of(context).colorScheme.tertiary,
      onChanged: (value) {
        setState(() {
          selectedFilter = value!;
        });
      },
    );
  }
}

void showFilterDialog(BuildContext context,
    {FilterStatus lastFilter = FilterStatus.all}) async {
  final FilterStatus? selectedFilter = await showDialog<FilterStatus>(
    barrierDismissible: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return FilterDialog(
        selectedFilter: lastFilter,
      );
    },
  );

  if (selectedFilter != null) {
    // ignore: use_build_context_synchronously
    context.read<TodoBloc>().add(FilterTodos(filterStatus: selectedFilter));
  }
}
