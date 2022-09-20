import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.onTap,
    required this.seconds,
    required this.maxSeconds,
  });
  final VoidCallback onTap;
  final int seconds;
  final int maxSeconds;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: null,
      child: CircleAvatar(
        radius: 78,
        child: seconds != 0 && seconds != maxSeconds
            ? Text(
                "$seconds",
                style: Theme.of(context).textTheme.headline4,
              )
            : Text(
                "GO",
                style: Theme.of(context).textTheme.headline4,
              ),
      ),
    );
  }
}
