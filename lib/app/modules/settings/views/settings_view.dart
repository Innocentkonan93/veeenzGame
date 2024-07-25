import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:veeenz/app/modules/settings/views/languages_view.dart';
import 'package:veeenz/utils/constants.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetWidget<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings'.tr,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Obx(
        () {
          if (controller.currentPlayer.value != null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return SizedBox.expand(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.music_note_rounded),
                  title: Text(
                    "Dark mode".tr,
                    style: theme.textTheme.titleMedium,
                  ),
                  trailing: SizedBox(
                    height: 30,
                    width: 50,
                    child: Switch.adaptive(
                      value: controller.isDark.value,
                      onChanged: (value) {
                        controller.isDark(value);
                        if (value) {
                          Get.changeThemeMode(ThemeMode.dark);
                        } else {
                          Get.changeThemeMode(ThemeMode.light);
                        }
                        controller.setThemeModeSettings(value);
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: Text(
                    "Music".tr,
                    style: theme.textTheme.titleMedium,
                  ),
                  trailing: SizedBox(
                    height: 30,
                    width: 50,
                    child: Switch.adaptive(
                      value: controller.isSoundEnabled.value,
                      onChanged: (value) {
                        controller.setSoundSettings(value);
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.translate_rounded),
                  title: Text(
                    "Language".tr,
                    style: theme.textTheme.titleMedium,
                  ),
                  onTap: () {
                    Get.to(() => const LanguagesView());
                  },
                  trailing: SizedBox(
                    height: 30,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          allLanguages.firstWhere(
                            (element) =>
                                element["locale"] ==
                                controller.selectedLanguage.value,
                          )['native_name'],
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          allLanguages.firstWhere(
                            (element) =>
                                element["locale"] ==
                                controller.selectedLanguage.value,
                          )['flag'],
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
