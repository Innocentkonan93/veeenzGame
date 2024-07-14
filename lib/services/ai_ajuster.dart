import 'package:veeenz/utils/constants.dart';

class AIDifficultyAdjuster {
  int playerPerformance = 0;

  /// Met à jour la performance du joueur en fonction de son succès ou échec.
  void updatePerformance(bool success) {
    if (success) {
      playerPerformance += 10;
    } else {
      playerPerformance -= 5;
    }
  }

  /// Retourne la durée de mouvement ajustée en fonction de la performance du joueur et du niveau.
  int getAdjustedMovementDuration(int level) {
    int baseDuration = getMovementDurationFromLevel(level);

    if (playerPerformance > 50) {
      return (baseDuration * 0.8)
          .toInt(); // Réduit la durée pour les bons joueurs
    } else if (playerPerformance < -20) {
      return (baseDuration * 1.2)
          .toInt(); // Augmente la durée pour les joueurs en difficulté
    } else {
      return baseDuration; // Durée normale
    }
  }
}
