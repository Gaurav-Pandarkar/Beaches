import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('hi'),
    const Locale('bn'),
    const Locale('te'),
    const Locale('mr'),
    const Locale('ta'),
    const Locale('ur'),
    const Locale('gu'),
    const Locale('ml'),
    const Locale('kn'),
    const Locale('or'),
    const Locale('pa'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'hi':
        return '🇮🇳'; // Hindi Flag
      case 'en':
        return '🇺🇸'; // English Flag
      case 'bn':
        return '🇧🇩'; // Bengali Flag
      case 'te':
        return '🇮🇳'; // Telugu Flag
      case 'mr':
        return '🇮🇳'; // Marathi Flag
      case 'ta':
        return '🇮🇳'; // Tamil Flag
      case 'ur':
        return '🇵🇰'; // Urdu Flag
      case 'gu':
        return '🇮🇳'; // Gujarati Flag
      case 'ml':
        return '🇮🇳'; // Malayalam Flag
      case 'kn':
        return '🇮🇳'; // Kannada Flag
      case 'or':
        return '🇮🇳'; // Odia Flag
      case 'pa':
        return '🇮🇳'; // Punjabi Flag
      default:
        return '🏳';
    }
  }
}
