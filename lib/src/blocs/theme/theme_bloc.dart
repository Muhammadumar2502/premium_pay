import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_new/src/core/constants/app_constants.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super( ThemeState(seedColor: AppConstant.primaryColor, appBrightness: true));

   changeThemeBrightness() {
    emit(state.copyWith(appBrightness: !state.appBrightness));
  }

   changeThemeColor(Color newColor) {
    emit(state.copyWith(seedColor: newColor));
  }
}