import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/app/modules/game/controllers/game_controller.dart';
import 'package:veeenz/models/quest.dart';

class QuestsView extends StatefulWidget {
  final List<Quest> quests;

  const QuestsView({super.key, required this.quests});

  @override
  State<QuestsView> createState() => _QuestsViewState();
}

class _QuestsViewState extends State<QuestsView> {
  bool started = false;
  @override
  void didUpdateWidget(covariant QuestsView oldWidget) {
    if (oldWidget.quests != widget.quests) {
      if (mounted) {}
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        started = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    GameController controller = Get.find<GameController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quests'.tr,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.quests.length,
        itemBuilder: (context, index) {
          final quest = widget.quests[index];
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 100)),
            decoration: BoxDecoration(
              // color: theme.colorScheme.pr,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(2),
            transform:
                Matrix4.translationValues(started ? 0 : -screenWidth, 0, 0),
            curve: Curves.easeInOutBack,
            child: ListTile(
              title: Text(
                quest.title,
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        quest.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text('${quest.progress} / ${quest.goal}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: quest.progress / quest.goal,
                    backgroundColor: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      quest.isCompleted ? Colors.green : Colors.blue,
                    ),
                  ),
                ],
              ),
              trailing: quest.isCompleted
                  ? SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.rewardPlayer(quest.reward);
                            },
                            child: const Text('Claim'),
                          )
                        ],
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
