import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/configs/responsive.dart';

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
    final size = MediaQuery.sizeOf(context);
    final theme = context.theme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(300),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: context.responsive<double>(
          size.width / 3,
          lg: size.width / 5,
        ),
        height: context.responsive<double>(
          size.width / 3,
          lg: size.width / 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.secondaryHeaderColor,
              theme.secondaryHeaderColor,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(60, 100, 100, 100),
              offset: Offset(-10.3, -10.3),
              blurRadius: 30,
              spreadRadius: 0.0,
            ),
            BoxShadow(
              color: Color.fromARGB(60, 100, 100, 100),
              offset: Offset(10.3, 10.3),
              blurRadius: 30,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Tap to'),
              Text(
                "Play",
                style: theme.textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
