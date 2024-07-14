import 'package:flutter/material.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Comment jouer',
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
                const Text(
                  'Bienvenue dans notre jeu !',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Objectif du jeu :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "L'objectif est de toucher le 'runner' pendant ses arrêts sur chaque alignement. Pour chaque niveau, un objectif est fixé que vous devez atteindre avant que le temps ne s'écoule.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Instructions :',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  '1. Lorsque le niveau commence, le runner commencera à se déplacer selon un schéma spécifique.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  '2. Votre objectif est de toucher le runner lorsqu\'il s\'arrête sur chaque alignement.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  '3. Vous devez atteindre l\'objectif du niveau avant que le temps ne s\'écoule.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  '4. Les niveaux deviennent plus difficiles avec des mouvements plus complexes et des temps plus courts.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 16),
                const Text(
                  'Conseils pour réussir',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Soyez rapide et précis dans vos mouvements.\n'
                  '• Pratiquez pour améliorer votre temps de réaction.\n'
                  '• Gardez un œil sur le motif de déplacement du "runner" pour anticiper ses arrêts.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 26),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bonne chance et amusez-vous bien !',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    child: const Text('Retour au jeu'),
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
