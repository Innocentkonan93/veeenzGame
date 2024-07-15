import 'package:flutter/material.dart';

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
  // Additional movements for variety
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
};

String getLevelDescription(int level) {
  switch (level) {
    case 1:
      return "Niveau 1 : Bienvenue dans l'aventure ! Apprenez les bases et commencez votre parcours. Bonne chance !";
    case 2:
      return "Niveau 2 : Super ! Vous maîtrisez les bases. Continuons à améliorer vos compétences.";
    case 3:
      return "Niveau 3 : Excellent travail ! Les défis deviennent plus intéressants. Montrez ce que vous avez appris.";
    case 4:
      return "Niveau 4 : Impressionnant ! Vous avancez rapidement. Préparez-vous pour des défis plus complexes.";
    case 5:
      return "Niveau 5 : Bravo ! Vous êtes à mi-chemin. Continuez à montrer votre détermination et vos compétences.";
    case 6:
      return "Niveau 6 : Fantastique ! Vous êtes presque au sommet. Poursuivez vos efforts.";
    case 7:
      return "Niveau 7 : Incroyable ! Vous êtes un champion. Les derniers défis vous attendent.";
    case 8:
      return "Niveau 8 : Félicitations ! Vous avez atteint le niveau final. Montrez votre maîtrise absolue.";
    case 9:
      return "Niveau 9 : Vous faites des progrès impressionnants. Poussez vos limites et continuez à briller.";
    case 10:
      return "Niveau 10 : Magnifique ! Votre parcours est inspirant. Préparez-vous pour des défis plus grands.";
    case 11:
      return "Niveau 11 : Vous êtes maintenant un expert. Utilisez votre expérience pour surmonter les obstacles.";
    case 12:
      return "Niveau 12 : Vos compétences sont indéniables. Continuez à exceller et à vous surpasser.";
    case 13:
      return "Niveau 13 : Vous êtes à la hauteur des plus grands. Poursuivez avec confiance et détermination.";
    case 14:
      return "Niveau 14 : Vous êtes proche du sommet. Continuez à gravir les échelons avec persévérance.";
    case 15:
      return "Niveau 15 : Votre talent est remarquable. Préparez-vous à affronter des défis inédits.";
    case 16:
      return "Niveau 16 : Vos efforts portent leurs fruits. Continuez à faire preuve de courage et de créativité.";
    case 17:
      return "Niveau 17 : Vous êtes un véritable modèle de réussite. Continuez à montrer l'exemple.";
    case 18:
      return "Niveau 18 : Vous êtes presque au bout de votre quête. Ne relâchez pas vos efforts maintenant.";
    case 19:
      return "Niveau 19 : Votre ténacité est exemplaire. Vous êtes sur le point de triompher.";
    case 20:
      return "Niveau 20 : Félicitations ! Vous avez atteint le niveau ultime. Votre parcours est une véritable inspiration.";
    default:
      return "Niveau $level : Continuez votre incroyable progression et relevez chaque défi avec brio !";
  }
}

int getMovementDurationFromLevel(int level) {
  if (level <= 9) return 1300;
  if (level >= 10 && level <= 19) return 1000;
  if (level >= 20) return 700;
  return 1300;
}

final allLanguages = <Map<String, dynamic>>[
  {"name": "English", "native_name": "English", "code": "en", "flag": "🇺🇸"},
  {"name": "Spanish", "native_name": "Español", "code": "es", "flag": "🇪🇸"},
  {"name": "French", "native_name": "Français", "code": "fr", "flag": "🇫🇷"},
  {"name": "Chinese", "native_name": "中文", "code": "zh", "flag": "🇨🇳"},
  {"name": "German", "native_name": "Deutsch", "code": "de", "flag": "🇩🇪"},
  {"name": "Japanese", "native_name": "日本語", "code": "ja", "flag": "🇯🇵"},
  {"name": "Korean", "native_name": "한국어", "code": "ko", "flag": "🇰🇷"},
  {
    "name": "Portuguese",
    "native_name": "Português",
    "code": "pt",
    "flag": "🇵🇹"
  },
  {"name": "Russian", "native_name": "Русский", "code": "ru", "flag": "🇷🇺"},
  {"name": "Arabic", "native_name": "العربية", "code": "ar", "flag": "🇸🇦"},
  {"name": "Italian", "native_name": "Italiano", "code": "it", "flag": "🇮🇹"},
  {"name": "Dutch", "native_name": "Nederlands", "code": "nl", "flag": "🇳🇱"},
  {"name": "Hindi", "native_name": "हिन्दी", "code": "hi", "flag": "🇮🇳"},
  {"name": "Bengali", "native_name": "বাংলা", "code": "bn", "flag": "🇧🇩"},
  {"name": "Swedish", "native_name": "Svenska", "code": "sv", "flag": "🇸🇪"},
  {"name": "Turkish", "native_name": "Türkçe", "code": "tr", "flag": "🇹🇷"},
  {"name": "Greek", "native_name": "Ελληνικά", "code": "el", "flag": "🇬🇷"},
  {
    "name": "Vietnamese",
    "native_name": "Tiếng Việt",
    "code": "vi",
    "flag": "🇻🇳"
  },
  {"name": "Thai", "native_name": "ไทย", "code": "th", "flag": "🇹🇭"},
  {"name": "Polish", "native_name": "Polski", "code": "pl", "flag": "🇵🇱"}
];
