import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString('language_code') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);

    notifyListeners();
  }
}





class LocalizationService {
  static final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'wish': 'Hello',
    },
    'te': {
      'wish': '	హలో',
    },
    'hi': {
      'wish': '	नमस्ते',
    },
    'ta': {
      'wish': '	வணக்கம்',
    },
  };

  static String translate(String key, String languageCode) {
    return _localizedStrings[languageCode]?[key] ??
        _localizedStrings['en']?[key] ??
        key;
  }
}

// 3. Create a translation helper widget (widgets/app_text.dart)

class AppText extends StatelessWidget {
  final String textKey;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.textKey, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  static String translate(BuildContext context, String key) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return LocalizationService.translate(
        key, languageProvider.locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final translatedText = LocalizationService.translate(
        textKey, languageProvider.locale.languageCode);

    return Text(
      translatedText,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}














