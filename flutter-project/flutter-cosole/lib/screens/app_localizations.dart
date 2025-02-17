import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'l10n/intl_messages_all.dart';  // Generated ARB files

class AppLocalizations {
  static var delegate;

  late String title;

  static Future<AppLocalizations> load(Locale locale) async {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    await initializeMessages(localeName);
    Intl.defaultLocale = localeName;

    return AppLocalizations();
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get appTitle => Intl.message('Select Your Language', name: 'appTitle');
  String get homeScreenTitle => Intl.message('Home', name: 'homeScreenTitle');
  String get goToHomeButton => Intl.message('Go to Home', name: 'goToHomeButton');
}

initializeMessages(String localeName) {
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi', 'bn', 'ta', 'ml', 'mr', 'gu'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
