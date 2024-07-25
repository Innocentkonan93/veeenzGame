import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'How to play ?'.tr,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to our game !'.tr,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Objective of the game :'.tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "The objective is to tag the 'runner' during their stops on each alignment. For each level, a target is set that you must reach before time runs out."
                      .tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Instructions :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "1. When the level begins, the runner will start moving according to a specific pattern."
                      .tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "2. Your objective is to tag the runner when they stop on each alignment."
                      .tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "3. You must reach the level's objective before time runs out."
                      .tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "4. The levels become more challenging with more complex movements and shorter time limits."
                      .tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 16),
                Text(
                  "Tips for success".tr,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Be quick and precise in your movements.'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '• Practice to improve your reaction time.'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '• Keep an eye on the runner’s movement pattern to anticipate their stops.'
                      .tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Good luck and have fun !'.tr,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 36.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Back to the game'.tr),
                  ),
                ),
                const SizedBox(height: 36.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
