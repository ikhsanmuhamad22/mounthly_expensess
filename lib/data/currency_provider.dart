import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final currency = ['Rupiah', 'Dollar'];

class CurrencyNotifier extends StateNotifier<String> {
  CurrencyNotifier() : super('Rupiah') {
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('currency_state') ?? 'Rupiah';
    state = saved;
  }

  Future<void> setCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency_state', currency);
    state = currency; // << ini trigger rebuild semua ref.watch
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, String>(
  (ref) => CurrencyNotifier(),
);
