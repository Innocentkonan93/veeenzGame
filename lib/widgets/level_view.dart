import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/configs/theme.dart';

class LevelView extends StatelessWidget {
  const LevelView({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(color: AppColor.white),
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
              color: Colors.white12,
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
                    style: Theme.of(context).textTheme.displayMedium!,
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
