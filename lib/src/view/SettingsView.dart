import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/ThemeController.dart';
import 'package:pontuador/src/model/Settings.dart';

class SettingsView extends StatefulWidget {
  Settings _settings;

  SettingsView(this._settings);

  @override
  State<SettingsView> createState() => _SettingsViewState(_settings);
}

class _SettingsViewState extends State<SettingsView> {
  Settings _settings;

  _SettingsViewState(this._settings);

  void updateTheme() {
    ThemeController().updateThemeMode(_settings);
    _settings.update();
  }

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
          ]),
    );
  }
}
