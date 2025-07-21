// lib/utils/translate.dart
import 'package:pet_crud_dvd/utils/app_config.dart';

String translate(String key) {
  return translations[currentLanguageCode]?[key] ?? key;
}
