import '/app/translations/en_US/en_us_translations.dart';
import '/app/translations/es_MX/es_mx_translations.dart';
import '/app/translations/pt_BR/pt_br_translations.dart';
import '/app/translations/ko_KR/ko_kr_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'pt_BR': ptBR,
    'en_US': enUs,
    'es_mx': esMx,
    'ko_KR': koKr,
  };
}
