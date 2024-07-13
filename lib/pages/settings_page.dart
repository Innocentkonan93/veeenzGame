import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.jost(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          SwitchListTile.adaptive(
            value: true,
            title: Text(
              "Musique",
              style: theme.textTheme.titleLarge,
            ),
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
