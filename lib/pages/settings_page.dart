import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: SizedBox.expand(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.music_note_rounded),
              title: Text(
                "Mode sombre",
                style: theme.textTheme.titleMedium,
              ),
              onTap: () {},
              trailing: SizedBox(
                height: 30,
                width: 50,
                child: Switch.adaptive(
                  value: true,
                  onChanged: (value) {
                    if (value) {
                      Get.changeThemeMode(ThemeMode.light);
                    } else {
                      Get.changeThemeMode(ThemeMode.dark);
                    }
                  },
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(
                "Musique",
                style: theme.textTheme.titleMedium,
              ),
              onTap: () {
                if (Get.isDarkMode) {
                  Get.changeThemeMode(ThemeMode.light);
                } else {
                  Get.changeThemeMode(ThemeMode.dark);
                }
              },
              trailing: SizedBox(
                height: 30,
                width: 50,
                child: Switch.adaptive(
                  value: true,
                  onChanged: (value) {
                    if (Get.isDarkMode) {
                      Get.changeThemeMode(ThemeMode.light);
                    } else {
                      Get.changeThemeMode(ThemeMode.dark);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
