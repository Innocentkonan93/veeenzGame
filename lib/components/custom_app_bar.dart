import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:veeenz/app/modules/game/controllers/game_controller.dart';
import 'package:veeenz/widgets/goal_view.dart';

import '../widgets/level_view.dart';

class CustomAppBar extends GetWidget<GameController>
    implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    Color textColor = controller.currentDecoration['text_color'];
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
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
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Hero(
                    tag: "level",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Level".tr,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Center(
                          child: Text(
                            controller.level.toString(),
                            style: theme.textTheme.titleLarge!
                                .copyWith(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // padding: const EdgeInsets.all(12),
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
                              style: theme.textTheme.titleLarge!
                                  .copyWith(color: textColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
