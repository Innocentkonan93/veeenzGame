import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelView extends StatelessWidget {
  const LevelView({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Hero(
          tag: "level",
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
                    "Level",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                  Text(
                    level.toString(),
                    style: theme.textTheme.displayMedium!.copyWith(
                      color: theme.colorScheme.primary,
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
