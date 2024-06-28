import 'package:easy_localization/easy_localization.dart';
import 'package:intl/date_symbol_data_local.dart';

initLanguages() async {
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting("ru_RU",null);
}
