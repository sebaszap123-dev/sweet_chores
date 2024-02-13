part of 'sweet_due_date_picker.dart';

class _CardDateTimePicker extends StatefulWidget {
  const _CardDateTimePicker({
    required this.title,
    required this.type,
    required this.onChangeDateOrTime,
  });

  final String title;
  final Picker type;
  final void Function(DateTime?) onChangeDateOrTime;

  @override
  State<_CardDateTimePicker> createState() => _CardDateTimePickerState();
}

class _CardDateTimePickerState extends State<_CardDateTimePicker> {
  final ExpandableController controller = ExpandableController();
  bool enable = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  DateTime? currentTime;
  String _getTimeOrDate() {
    if (currentTime != null) {
      return Picker.date == widget.type
          ? parseDueDate(currentTime!.millisecondsSinceEpoch)
          : timeFormatted(currentTime!);
    } else {
      return Picker.date == widget.type ? 'Today' : '00:00';
    }
  }

  _disableTime() {
    context.read<SweetChoresNotesBloc>().add(const DateChoresEvent(false));
  }

  _updateInnerDateOrTime(DateTime value) {
    setState(() {
      currentTime = value;
    });
    widget.onChangeDateOrTime(value);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToExpand: enable,
        tapBodyToCollapse: enable,
        hasIcon: false,
        tapHeaderToExpand: enable,
      ),
      controller: controller,
      collapsed: Container(),
      expanded: _buildPickerContent(),
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 240,
            child: ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: Icon(
                widget.type == Picker.date
                    ? Icons.calendar_month
                    : Icons.timelapse_outlined,
              ),
              minLeadingWidth: 10,
              title: Text(widget.title),
              subtitle: enable ? _buildSubtitle() : null,
            ),
          ),
          Switch(
            value: enable,
            onChanged: (value) {
              if (enable && controller.expanded == false) {
                setState(() {
                  enable = value;
                  currentTime = null;
                  widget.onChangeDateOrTime(currentTime);
                });
              } else {
                controller.toggle();
                setState(() {
                  enable = value;
                  if (Picker.date == widget.type && enable) {
                    currentTime ??= DateTime.now();
                    DateTime date = DateTime(
                      currentTime!.year,
                      currentTime!.month,
                      currentTime!.day,
                    );
                    currentTime = date;
                    widget.onChangeDateOrTime(currentTime);
                  } else if (!enable) {
                    currentTime = null;
                    widget.onChangeDateOrTime(currentTime);
                  }
                  if (Picker.time == widget.type && !enable) {
                    _disableTime();
                  }
                });
              }
              if (mounted) {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPickerContent() {
    if (widget.type == Picker.date) {
      return CalendarPicker(
        onDateChanged: _updateInnerDateOrTime,
      );
    } else {
      return TimePicker(
        onTimeSelected: _updateInnerDateOrTime,
      );
    }
  }

  Widget _buildSubtitle() {
    return Text(_getTimeOrDate());
  }
}
