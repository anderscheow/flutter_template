import 'dart:ui';

const String english = 'en';
const String chinese = 'zh';

const String simplified = 'Hans';
const String traditional = 'Hant';

const List<Locale> supportedLocales = [
  Locale.fromSubtags(languageCode: english),
  Locale.fromSubtags(languageCode: chinese),
  Locale.fromSubtags(languageCode: chinese, scriptCode: simplified),
  Locale.fromSubtags(languageCode: chinese, scriptCode: traditional),
];
