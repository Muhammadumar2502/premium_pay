import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.seedColor, required this.appBrightness});

  final Color seedColor;
  final bool appBrightness;

  @override
  List<Object> get props => [seedColor, appBrightness];


  ThemeState copyWith({
    Color? seedColor,
    bool? appBrightness,
  }) {
    return ThemeState(
      seedColor: seedColor ?? this.seedColor,
      appBrightness: appBrightness ?? this.appBrightness,
    );
  }
}