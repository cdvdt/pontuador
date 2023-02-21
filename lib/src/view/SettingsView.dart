import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/ThemeController.dart';
import 'package:pontuador/src/controller/TimeStampController.dart';
import 'package:pontuador/src/model/Settings.dart';
import 'package:pontuador/src/view/CustomDialog.dart';
import 'package:pontuador/src/view/widget/DateSelector.dart';
import 'package:pontuador/src/controller/DateTimeController.dart';

class SettingsView extends StatefulWidget {
  Settings _settings;

  SettingsView(this._settings);

  @override
  State<SettingsView> createState() => _SettingsViewState(_settings);
}

class _SettingsViewState extends State<SettingsView> {
  Settings _settings;

  _SettingsViewState(this._settings);

  DateTime _from = DateTimeController.toStartOfDay(DateTime.now());
  DateTime _to = DateTimeController.toEndOfDay(DateTime.now());

  void updateTheme() {
    ThemeController().updateThemeMode(_settings);
    _settings.update();
  }

  _deleteItems(BuildContext context) => CustomDialog.question(context,
      title: "Confirm deletion",
      message: "Are you sure?", handler: (value) {
        if (value) TimeStampController().removeByPeriod(_from, _to);
      });

  @override
  Widget build(BuildContext context) {
    var useSystemTheme = widget._settings.useSystemTheme;
    var useDarkMode = widget._settings.useDarkMode;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('System theme'),
              subtitle: const Text('Use theme defined by system'),
              onChanged: (bool value) => setState(() {
                _settings.useSystemTheme = value;
                updateTheme();
              }),
              value: useSystemTheme,
            ),
            SwitchListTile(
              title: const Text('Dark mode'),
              subtitle: const Text('Use always dark mode'),
              onChanged: useSystemTheme
                  ? null
                  : (bool value) => setState(() {
                        widget._settings.useDarkMode = value;
                        updateTheme();
                      }),
              value: useDarkMode,
            ),
            Divider(),
            ListTile(
              title: Text('Manage data'),
              subtitle: Row(
                children: [
                  Text('From:'),
                  DateSelector(
                      currentDate: _from, onSelected: (picked) => setState(() => _from = DateTimeController.toStartOfDay(picked))),
                  Text('To:'),
                  DateSelector(
                      currentDate: _to, onSelected: (picked) => setState(() => _to = DateTimeController.toEndOfDay(picked))),
                ],
              ),
              trailing: TextButton(onPressed: () => _deleteItems(context), child: Text('Delete')),
            )
          ]),
    );
  }
}
