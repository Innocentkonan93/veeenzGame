import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'package:veeenz/app/modules/game/controllers/game_controller.dart';
import 'package:veeenz/app/configs/app_colors.dart';
import 'package:veeenz/app/modules/home/controllers/home_controller.dart';
import 'package:veeenz/widgets/goal_view.dart';

import '../widgets/level_view.dart';

class CustomAppBar extends GetWidget<GameController> {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    // Color textColor = controller.currentDecoration['text_color'];
    HomeController homeController = Get.find<HomeController>();
    return Obx(() {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.1),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      homeController.showProfileDialog();
                    },
                    child: const CircleAvatar(
                      child: Icon(CupertinoIcons.person_alt),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return LevelView(
                              level: controller.level.value,
                            );
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Hero(
                          tag: "level",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Level".tr,
                                style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.grey),
                              ),
                              Center(
                                child: Text(
                                  controller.level.toString(),
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .slideX(begin: -1, end: 0, curve: Curves.bounceInOut)
                        .fadeIn(),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return GoalWiew(
                        levelGoal: controller.target.value,
                      );
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ));
                },
                child: Container(
                  width: 100,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Hero(
                      tag: "target",
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              "assets/images/flutter_dash.png",
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                (controller.target.value -
                                        controller.positionCaptured.length)
                                    .toString(),
                                style: theme.textTheme.titleLarge!.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .slideX(begin: 1, end: 0, curve: Curves.bounceInOut
                        // delay: const Duration(milliseconds: 400),
                        )
                    .fadeIn(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
