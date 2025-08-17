import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<Brightness> {
  ThemeNotifier() : super(Brightness.light) {
    _loadTheme();
  }

  static const String _themeKey = "app_theme";

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    state = Brightness.values[themeIndex];
  }

  Future<void> setTheme(Brightness brightness) async {
    state = brightness;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, brightness.index);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, Brightness>((ref) {
  return ThemeNotifier();
});
