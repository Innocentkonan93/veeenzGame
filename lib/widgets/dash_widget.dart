import 'dart:math';

import 'package:flutter/material.dart';

class DashWidget extends StatefulWidget {
  const DashWidget({
    super.key,
  });

  @override
  State<DashWidget> createState() => _DashWidgetState();
}

class _DashWidgetState extends State<DashWidget> with TickerProviderStateMixin {
  final double dashSize = 300;
  late final holeSizeTween = Tween<double>(
    begin: 0,
    end: 1.2 * dashSize,
  );

  late final holeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final dashOffsetAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final dashOffsetTween = Tween<double>(
    end: 0,
    begin: 2 * dashSize,
  ).chain(
    CurveTween(curve: Curves.easeInOutBack),
  );

  late final dashRotationTween = Tween<double>(
    begin: 0,
    end: 0.5,
  ).chain(
    CurveTween(curve: Curves.easeInOutBack),
  );

  late final dashElevationTween = Tween<double>(
    begin: 0,
    end: 20,
  );
  double get holeSize => holeSizeTween.evaluate(holeAnimationController);
  double get dashOffset =>
      dashOffsetTween.evaluate(dashOffsetAnimationController);
  double get dashRotation =>
      dashRotationTween.evaluate(dashOffsetAnimationController);
  double get dashElevation =>
      dashElevationTween.evaluate(dashOffsetAnimationController);

  @override
  void dispose() {
    holeAnimationController.dispose();
    dashOffsetAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    holeAnimationController.addListener(
      () => setState(() {}),
    );

    dashOffsetAnimationController.addListener(
      () => setState(() {}),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAsync();
    });

    super.initState();
  }

  void _initAsync() async {
    await startAnimation();
    // Perform any further operations that need to happen after the async operation
    setState(() {
      // Update the state if needed
    });
  }

  Future<void> startAnimation() async {
    // Perform your async operations here, for example:
    await holeAnimationController.forward();
    dashOffsetAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      holeAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dashSize * 1.1,
      width: double.infinity,
      // constraints: const BoxConstraints(
      //   maxWidth: 300,
      // ),
      child: ClipPath(
        clipper: BlackHoleClipper(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: holeSize,
              child: Image.asset(
                "assets/images/hole.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              child: Center(
                child: Transform.translate(
                  offset: Offset(0, dashOffset),
                  child: Image.asset(
                    "assets/images/flutter_dash.png",
                    height: dashSize,
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

class BlackHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        width: size.width,
        height: size.height / 1000,
      ),
      0,
      pi,
      true,
    );
    // Using -1000 guarantees the card won't be clipped at the top, regardless of its height
    path.lineTo(0, -1000);
    path.lineTo(size.width, -1000);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(BlackHoleClipper oldClipper) => false;
}
