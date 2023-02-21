import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final DateTime currentDate;
  final void Function(DateTime selectedDate) onSelected;
  final Widget? icon;

  final DateTime? _lowLimit;
  DateTime get _lowLimitSafe => _lowLimit ?? DateTime(2000);
  final DateTime? _highLimit;
  DateTime get _highLimitSafe => _highLimit ?? DateTime(2100);

  const DateSelector(
      {Key? key,
      this.icon,
      required this.currentDate,
      required this.onSelected,
      DateTime? lowLimit,
      DateTime? highLimit})
      : _lowLimit = lowLimit,
        _highLimit = highLimit,
        super(key: key);

  Future<void> _picker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: _lowLimitSafe,
        lastDate: _highLimitSafe);
    if (picked != null) {
      onSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return TextButton(
          clipBehavior: Clip.antiAlias,
          onPressed: () => _picker(context),
          child: Text(DateFormat("dd/MM/yyyy").format(currentDate)));
    } else {
      return TextButton.icon(
        icon: icon!,
        clipBehavior: Clip.antiAlias,
        onPressed: () => _picker(context),
        label: Text(DateFormat("dd/MM/yyyy").format(currentDate)),
      );
    }
  }
}
