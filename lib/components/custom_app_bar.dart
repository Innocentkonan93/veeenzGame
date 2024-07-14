import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeenz/widgets/goal_view.dart';

import '../widgets/level_view.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.levelTarget,
  });

  final int levelTarget;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int? level;

  @override
  void initState() {
    getPlayerLevel();
    super.initState();
  }

  getPlayerLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getInt("level") ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
                        level: level ?? 1,
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
                  color: theme.colorScheme.surfaceTint.withOpacity(.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Hero(
                  tag: "level",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Level ",
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      if (level != null)
                        Center(
                          child: Text(
                            level.toString(),
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
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
                      levelGoal: widget.levelTarget,
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
                  color: theme.colorScheme.surfaceTint.withOpacity(.1),
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
                            widget.levelTarget.toString(),
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
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
  }
}
