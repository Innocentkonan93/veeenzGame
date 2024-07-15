import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/app/modules/settings/controllers/settings_controller.dart';
import 'package:veeenz/configs/app_colors.dart';
import 'package:veeenz/utils/constants.dart';

class LanguagesView extends GetWidget<SettingsController> {
  const LanguagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    controller.getLanguageSettings();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Languages',
          style: theme.textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.selectedLanguage.value.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Select your preferred language'),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: allLanguages.length,
                  itemBuilder: (context, index) {
                    final language = allLanguages[index];
                    final flag = language['flag'];
                    final code = language['code'];
                    final name = language['name'];
                    return GestureDetector(
                      onTap: () {
                        controller.selectedLanguage(code);
                        controller.setLanguage(code);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.selectedLanguage.value == code
                              ? theme.colorScheme.surfaceTint.withOpacity(.3)
                              : null,
                          border: Border.all(
                            width: .5,
                            color: controller.selectedLanguage.value == code
                                ? theme.colorScheme.surfaceTint
                                : AppColors.grey.withOpacity(.5),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                flag,
                                style: const TextStyle(fontSize: 50),
                              ),
                              Text(
                                name,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle save button click
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
