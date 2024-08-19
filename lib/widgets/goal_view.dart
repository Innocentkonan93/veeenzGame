import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/app/modules/home/views/how_to_play_page.dart';

class GoalWiew extends StatelessWidget {
  const GoalWiew({super.key, required this.levelGoal});

  final int levelGoal;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const HowToPlayPage(),
              );
            },
            icon: const Icon(CupertinoIcons.question_circle),
          )
        ],
      ),
      body: Center(
        child: Hero(
          tag: "target",
          child: Container(
            padding: const EdgeInsets.all(30),
            // height: Get.width / 2,
            width: Get.width / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: theme.colorScheme.surfaceTint.withOpacity(.1),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Target".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/flutter_dash.png",
                          width: 40,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          levelGoal.toString(),
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
