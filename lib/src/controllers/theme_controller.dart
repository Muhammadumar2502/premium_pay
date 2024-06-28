import 'package:premium_pay_new/export_files.dart';

class ThemeController {
  static Future<void> changeThemeBrightness(
    BuildContext context,
  ) async {
    try {
      await BlocProvider.of<ThemeCubit>(context).changeThemeBrightness();
    } catch (e, track) {
      print("ThemeManager Error >>" + e.toString());
      print("ThemeManager track >>" + track.toString());
    }
  }
}
