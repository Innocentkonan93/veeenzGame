import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Runner extends StatelessWidget {
  const Runner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary.withOpacity(.3),
            borderRadius: BorderRadius.circular(4),
          ),
          // child: const FlutterLogo(
          //   size: 50,
          //   textColor: Colors.grey,
          // ),

          child: Image.asset(
            'assets/images/flutter_dash.png',
            width: 50,
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
