import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:veeenz/app/configs/theme.dart';
import 'package:veeenz/app/modules/home/controllers/home_controller.dart';
import 'package:veeenz/app/modules/home/views/home_view.dart';

class ProfileDialog extends GetWidget<HomeController> {
  const ProfileDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Obx(() {
      if (controller.currentPlayer.value != null &&
          controller.currentPlayer.value!.name.isEmpty) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
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
                      Icons.person,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Ajouter votre nom",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColor.red,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: controller.nameController,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      // contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.setPlayerName();
                          Get.back(result: true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 0.0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(12),
                        ),
                        child: Text(
                          'Valider',
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                          ),
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

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
        insetPadding: const EdgeInsets.all(5),
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Profil',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: AppColor.white,
                  ),
                ),
                actions: [
                  IconButton.filledTonal(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                ),
                padding: const EdgeInsets.all(6),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                child: Icon(
                                  Icons.person,
                                  size: 35,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.green,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppColor.black,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.currentPlayer.value?.name ?? "",
                                  textAlign: TextAlign.center,
                                  style:
                                      theme.textTheme.headlineMedium?.copyWith(
                                    color: AppColor.red,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Niveau",
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                controller.currentPlayer.value!.position
                                    .toString(),
                                style: theme.textTheme.displaySmall?.copyWith(
                                  color: AppColor.red,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                ),
                padding: const EdgeInsets.all(6),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
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
                ),
              ).animate().slideY(),
            ],
          ),
        ),
      );
    });
  }
}
