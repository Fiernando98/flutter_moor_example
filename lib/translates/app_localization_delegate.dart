import 'package:flutter/cupertino.dart';
import 'package:flutter_moor_example/translates/languages/language_en.dart';
import 'package:flutter_moor_example/translates/languages/language_es.dart';
import 'package:flutter_moor_example/translates/translates.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Translates> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      languagesSupported.contains(locale.languageCode);

  @override
  Future<Translates> load(Locale locale) => _load(locale);

  static Future<Translates> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'es':
        return LanguageEs();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translates> old) => false;
}
