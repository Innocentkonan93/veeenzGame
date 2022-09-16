import 'dart:async';

import 'package:flutter/material.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({super.key});

  @override
  State<GamingPage> createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
  AlignmentGeometry alignment = Alignment.topCenter;
  int now = 0;
  Timer? _debounce;
  List<Widget> widgets = [];
  List<AlignmentGeometry> positionCaptured = [];

  bool isCompleted = false;
  bool isStart = false;
  Duration durationUse = Duration.zero;
  @override
  void initState() {
    super.initState();
  }

  void changeAligment(int tick) {
    switch (tick) {
      case 0:
        setState(() {
          alignment = Alignment.topCenter;
        });
        break;
      case 1:
        setState(() {
          alignment = Alignment.topRight;
        });
        break;
      case 2:
        setState(() {
          alignment = Alignment.centerRight;
        });
        break;
      case 3:
        setState(() {
          alignment = Alignment.bottomRight;
        });
        break;
      case 4:
        setState(() {
          alignment = Alignment.bottomCenter;
        });
        break;
      case 5:
        setState(() {
          alignment = Alignment.bottomLeft;
        });
        break;
      case 6:
        setState(() {
          alignment = Alignment.centerLeft;
        });
        break;
      case 7:
        setState(() {
          alignment = Alignment.topLeft;
        });
        break;
      case 8:
        setState(() {
          alignment = Alignment.topCenter;
        });
        break;
      default:
        _debounce?.cancel();
    }
  }

  void start() {
    setState(() {
      isStart = true;
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        if (isCompleted) {
          now--;
        } else {
          now++;
          print(isCompleted);
        }
      }
      if (now >= 8) {
        setState(() {
          isCompleted = true;
        });
      }
      if (now <= 0) {
        setState(() {
          isCompleted = false;
        });
      }
      print(now);
      changeAligment(now);
    });
  }

  void stop() {
    _debounce!.cancel();
    now = 0;
    setState(() {
      isStart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   leading: BackButton(onPressed: () {
      //     _debounce?.cancel();
      //   }),
      // ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: alignment,
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceOut,
                child: InkWell(
                  onTap: () {
                    if (isStart == true) {
                      widgets.add(
                        Align(
                          alignment: alignment,
                          child: const FlutterLogo(
                              size: 40, textColor: Colors.grey),
                        ),
                      );
                    }
                    if (!positionCaptured.contains(alignment)) {
                      positionCaptured.add(alignment);
                    }
                    print(positionCaptured);
                  },
                  child: const FlutterLogo(size: 40),
                ),
              ),
              ...widgets.toList(),
              Container(
                margin: const EdgeInsets.all(50),
                color: Colors.white24,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (isStart == false) {
                        start();
                      } else {
                        stop();
                      }
                    },
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor:
                          isStart == false ? Colors.green : Colors.red,
                      child: isStart == false
                          ? Text(
                              "Start",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          : Text(
                              'Stop',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: Alimated,
        ),
      ),
    );
  }
}
