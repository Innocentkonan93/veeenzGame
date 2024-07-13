import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:veeenz/configs/theme.dart';

class CountDown extends StatelessWidget {
  const CountDown({
    super.key,
    required this.percent,
    required this.oldCount,
    required this.seconds,
  });
  final double percent;
  final int? oldCount;
  final int seconds;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CircularPercentIndicator(
      radius: 93.0,
      animationDuration: 1200,
      lineWidth: 15.0,
      percent: percent,
      backgroundColor: Colors.transparent,
      progressColor: theme.colorScheme.secondary,
      circularStrokeCap: CircularStrokeCap.round,
      center: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 78,
        child: Center(
          child: TweenAnimationBuilder<double>(
            key: ValueKey(oldCount),
            duration: const Duration(seconds: 1),
            tween: Tween(
              begin: 0.0,
              end: 1.0,
            ),
            builder: (context, value, child) {
              return Stack(
                children: [
                  if (oldCount != null)
                    Opacity(
                      opacity: 1 - value,
                      child: Transform.translate(
                        offset: Offset(50 * value, 0.0),
                        child: Text(
                          oldCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: AppColor.red),
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(-05 * (1 - value), 0.0),
                    child: Text(
                      seconds.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: AppColor.red),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
