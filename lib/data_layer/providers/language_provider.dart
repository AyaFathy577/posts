import 'package:flutter/material.dart';
import 'package:posts/constants/variables.dart';
import 'package:posts/localization/language_constants.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale =
      const Locale(Variables.arabicLangCode, Variables.arabicCountryCode);

  Locale? get locale => _locale;

  LanguageProvider() {
    getLocale().then((locale) {
      _locale = locale;
    });
  }

  updateLanguage(Locale value) async {
    await setLocale(value.languageCode);
    _locale = value;
    notifyListeners();
  }
}
