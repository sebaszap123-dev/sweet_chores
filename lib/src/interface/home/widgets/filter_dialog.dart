import 'package:flutter/material.dart';
import 'package:sweet_chores/src/config/themes/themes.dart';
import 'package:sweet_chores/src/core/app_export.dart';
import 'package:sweet_chores/src/data/data_source.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key, required this.selectedFilter});

  @override
  FilterDialogState createState() => FilterDialogState();

  final FilterTime selectedFilter;
}

class FilterDialogState extends State<FilterDialog> {
  late FilterTime selectedFilter;

  @override
  void initState() {
    selectedFilter = widget.selectedFilter;
    super.initState();
  }

  Color get _textColor {
    if (context.read<SweetPreferencesBloc>().state.typeTheme ==
            SweetTheme.strawberry &&
        !context.read<SweetPreferencesBloc>().state.isDarkMode) {
      return Colors.black;
    }
    if (context.read<SweetPreferencesBloc>().state.typeTheme ==
            SweetTheme.cinnamon &&
        context.read<SweetPreferencesBloc>().state.isDarkMode) {
      return Colors.white;
    }
    return Theme.of(context).colorScheme.tertiary;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        'Filter chores',
        style: TextStyle(
          color: _textColor,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterRadio(
                FilterTime.all, 'All', Icons.calendar_today), // Agrega icono
            _buildFilterRadio(FilterTime.today, 'Today', Icons.today),
            _buildFilterRadio(
                FilterTime.week, 'This week', Icons.calendar_month),
            _buildFilterRadio(FilterTime.month, 'This Month', Icons.date_range),
            _buildFilterRadio(
                FilterTime.overDue, 'Overdue', Icons.warning_amber),
            _buildFilterRadio(FilterTime.done, 'Done', Icons.check_circle),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: _textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRadio(FilterTime filter, String label, IconData icon) {
    return RadioListTile<FilterTime>(
      enableFeedback: true,
      title: Row(
        children: [
          Icon(
            icon,
            color: _textColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: _textColor),
          ),
        ],
      ),
      value: filter,
      groupValue: selectedFilter,
      activeColor: _textColor,
      onChanged: (value) {
        setState(() {
          selectedFilter = value!;
        });
        Future.delayed(const Duration(milliseconds: 300));
        Navigator.of(context).pop(selectedFilter);
      },
    );
  }
}

void showFilterDialog(BuildContext context,
    {FilterTime lastFilter = FilterTime.all}) async {
  final FilterTime? selectedFilter = await showDialog<FilterTime>(
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
    context.read<SweetChoresNotesBloc>().add(FilterTimeEvent(selectedFilter));
  }
}
