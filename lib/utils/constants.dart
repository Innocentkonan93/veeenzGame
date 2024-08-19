import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veeenz/models/quest.dart';
import 'package:veeenz/models/reward.dart';

const movementMap = {
  // Circle movement
  0: Alignment.topCenter,
  1: Alignment.topRight,
  2: Alignment.centerRight,
  3: Alignment.bottomRight,
  4: Alignment.bottomCenter,
  5: Alignment.bottomLeft,
  6: Alignment.centerLeft,
  7: Alignment.topLeft,
  8: Alignment.topCenter,

  // Z movement
  9: Alignment.topLeft,
  10: Alignment.topCenter,
  11: Alignment.topRight,
  12: Alignment.bottomLeft,
  13: Alignment.bottomCenter,
  14: Alignment.bottomRight,
  15: Alignment.centerLeft,
  16: Alignment.centerRight,

  // N movement
  17: Alignment.bottomLeft,
  18: Alignment.centerLeft,
  19: Alignment.topLeft,
  20: Alignment.bottomRight,
  21: Alignment.centerRight,
  22: Alignment.topRight,
  23: Alignment.topCenter,
  24: Alignment.bottomCenter,

  // Diagonal movement
  25: Alignment.topLeft,
  26: Alignment.bottomRight,
  27: Alignment.topRight,
  28: Alignment.bottomLeft,

  // Horizontal movement
  29: Alignment.centerLeft,
  30: Alignment.centerRight,

  // Vertical movement
  31: Alignment.topCenter,
  32: Alignment.bottomCenter,

  // Zigzag movement
  33: Alignment.topLeft,
  34: Alignment.centerRight,
  35: Alignment.bottomLeft,
  36: Alignment.topRight,
  37: Alignment.centerLeft,
  38: Alignment.bottomRight,

  // Spiral movement (starting from center)
  39: Alignment.center,
  40: Alignment.topCenter,
  41: Alignment.topRight,
  42: Alignment.centerRight,
  43: Alignment.bottomRight,
  44: Alignment.bottomCenter,
  45: Alignment.bottomLeft,
  46: Alignment.centerLeft,
  47: Alignment.topLeft,
  48: Alignment.center,

  // Square movement
  49: Alignment.topLeft,
  50: Alignment.topRight,
  51: Alignment.bottomRight,
  52: Alignment.bottomLeft,
  53: Alignment.topLeft,

  // Figure-eight movement
  54: Alignment.topLeft,
  55: Alignment.center,
  56: Alignment.bottomRight,
  57: Alignment.center,
  58: Alignment.topRight,
  59: Alignment.center,
  60: Alignment.bottomLeft,
  61: Alignment.center,

  // Triangle movement
  62: Alignment.topCenter,
  63: Alignment.bottomRight,
  64: Alignment.bottomLeft,
  65: Alignment.topCenter,

  // Cross movement
  66: Alignment.topCenter,
  67: Alignment.centerLeft,
  68: Alignment.bottomCenter,
  69: Alignment.centerRight,
  70: Alignment.topCenter,

  // Wave movement
  71: Alignment.bottomLeft,
  72: Alignment.centerLeft,
  73: Alignment.topLeft,
  74: Alignment.topCenter,
  75: Alignment.topRight,
  76: Alignment.centerRight,
  77: Alignment.bottomRight,

  // Randomized movement
  78: Alignment.centerLeft,
  79: Alignment.bottomRight,
  80: Alignment.topCenter,
  81: Alignment.bottomLeft,
  82: Alignment.topRight,
  83: Alignment.centerRight,
  84: Alignment.topLeft,
  85: Alignment.bottomCenter,

  // Heart shape movement
  86: Alignment.center,
  87: Alignment.topCenter,
  88: Alignment.topRight,
  89: Alignment.centerRight,
  90: Alignment.bottomRight,
  91: Alignment.bottomCenter,
  92: Alignment.bottomLeft,
  93: Alignment.centerLeft,
  94: Alignment.topLeft,
  95: Alignment.topCenter,

  // Star shape movement
  96: Alignment.topCenter,
  97: Alignment.centerRight,
  98: Alignment.bottomLeft,
  99: Alignment.topRight,
  100: Alignment.bottomCenter,
  101: Alignment.topLeft,
  102: Alignment.bottomRight,
  103: Alignment.centerLeft,
  104: Alignment.topCenter,
};

String getLevelDescription(int level) {
  switch (level) {
    case 1:
      return "Welcome to the adventure! Learn the basics and start your journey. Good luck!"
          .tr;
    case 2:
      return "Great! You have mastered the basics. Let's continue to improve your skills."
          .tr;
    case 3:
      return "Excellent work! The challenges are getting more interesting. Show what you've learned."
          .tr;
    case 4:
      return "Impressive! You're progressing quickly. Get ready for more complex challenges."
          .tr;
    case 5:
      return "Well done! You're halfway there. Keep showing your determination and skills."
          .tr;
    case 6:
      return "Fantastic! You're almost at the top. Keep pushing forward.".tr;
    case 7:
      return "Incredible! You're a champion. The final challenges await you."
          .tr;
    case 8:
      return "Congratulations! You've reached the final level. Show your absolute mastery."
          .tr;
    case 9:
      return "You're making impressive progress. Push your limits and keep shining."
          .tr;
    case 10:
      return "Magnificent! Your journey is inspiring. Get ready for bigger challenges."
          .tr;
    case 11:
      return "You're now an expert. Use your experience to overcome obstacles."
          .tr;
    case 12:
      return "Your skills are undeniable. Keep excelling and surpassing yourself."
          .tr;
    case 13:
      return "You're on par with the greatest. Continue with confidence and determination."
          .tr;
    case 14:
      return "You're close to the top. Keep climbing with perseverance.".tr;
    case 15:
      return "Your talent is remarkable. Get ready to face new challenges."
          .tr;
    case 16:
      return "Your efforts are paying off. Keep showing courage and creativity."
          .tr;
    case 17:
      return "You're a true model of success. Keep setting the example."
          .tr;
    case 18:
      return "You're almost at the end of your quest. Don't let up now."
          .tr;
    case 19:
      return "Your tenacity is exemplary. You're on the verge of triumph.".tr;
    case 20:
      return "Congratulations! You've reached the ultimate level. Your journey is a true inspiration."
          .tr;
    default:
      return "Continue your incredible progress and tackle each challenge with brilliance!".tr;
  }
}

int getMovementDurationFromLevel(int level) {
  if (level <= 9) return 1300;
  if (level >= 10 && level <= 19) return 1000;
  if (level >= 20) return 700;
  return 1300;
}

final allLanguages = <Map<String, dynamic>>[
  {
    "name": "English",
    "native_name": "English",
    "code": "en",
    "flag": "🇺🇸",
    "locale": "en_US"
  },
  {
    "name": "Français",
    "native_name": "Français",
    "code": "fr",
    "flag": "🇫🇷",
    "locale": "fr_FR"
  },
  // {
  //   "name": "Español",
  //   "native_name": "Español",
  //   "code": "es",
  //   "flag": "🇪🇸",
  //   "locale": "es_ES"
  // },
  // {
  //   "name": "Deutsch",
  //   "native_name": "Deutsch",
  //   "code": "de",
  //   "flag": "🇩🇪",
  //   "locale": "de_DE"
  // },
  // {
  //   "name": "Italiano",
  //   "native_name": "Italiano",
  //   "code": "it",
  //   "flag": "🇮🇹",
  //   "locale": "it_IT"
  // },
  // {
  //   "name": "Português",
  //   "native_name": "Português",
  //   "code": "pt",
  //   "flag": "🇵🇹",
  //   "locale": "pt_PT"
  // },
];

final allGameBackgrounds = <Map<String, dynamic>>[
  {
    "level": 1,
    "image": "dices.jpg",
    "text_color": Colors.black,
  },
  {
    "level": 20,
    "image": "fantasy.jpg",
    "text_color": Colors.white,
  },
  {
    "level": 30,
    "image": "moon.jpg",
    "text_color": Colors.white,
  },
  {
    "level": 40,
    "image": "mountains.jpg",
    "text_color": Colors.white,
  },
  {
    "level": 50,
    "image": "mushroom.jpg",
    "text_color": Colors.white,
  },
  {
    "level": 60,
    "image": "neon.jpg",
    "text_color": Colors.white,
  },
  {
    "level": 100,
    "image": "squares.jpg",
    "text_color": Colors.white,
  },
];

Map<String, dynamic> getDecorationForLevel(int level) {
  Map<String, dynamic>? decoration;

  for (var bg in allGameBackgrounds) {
    if (bg['level'] <= level) {
      decoration = bg;
    } else {
      break;
    }
  }

  return decoration ?? allGameBackgrounds.first;
}

final List<Reward> availableRewards = [
  Reward(
    id: 1,
    name: 'Gold Coin',
    description: 'A valuable gold coin.',
    value: 10,
  ),
  Reward(
    id: 2,
    name: 'Silver Coin',
    description: 'A shiny silver coin.',
    value: 5,
  ),
  Reward(
    id: 3,
    name: 'XP Boost',
    description: 'Increases experience points.',
    value: 20,
  ),
  // Ajoutez plus de récompenses selon vos besoins
];

final List<Quest> allGameQuests = [
  Quest(
    id: '1',
    title: 'First Catch',
    description: 'Catch the runner for the first time.',
    type: QuestType.catchRunner,
    goal: 1,
    rewards: [10],
    progress: 1,
  ),
  Quest(
    id: '2',
    title: 'Level Up',
    description: 'Reach level 10.',
    type: QuestType.reachLevel,
    goal: 10,
    rewards: [20],
    progress: 0,
  ),
  // Add more quests as needed
];
// enum FeedbackType {
//   success,
//   error,
//   warning,
//   selection,
//   impact,
//   heavy,
//   medium,
//   light
// }
