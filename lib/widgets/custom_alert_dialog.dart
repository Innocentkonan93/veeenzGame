import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/app/configs/theme.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      insetPadding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21),
        ),
        padding: const EdgeInsets.all(6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 0),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.home,
                  size: 35,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Vous voulez quittez le jeu ?",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: AppColor.red,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "En quittant le jeu la partie sera terminée !",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      elevation: 0.0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: Text(
                      'Oui',
                      style: TextStyle(
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Get.offAll(() => const HomeView());
                      Get.back(result: false);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Text(
                      'Non',
                      // style: theme.textTheme.titleLarge!.copyWith(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
