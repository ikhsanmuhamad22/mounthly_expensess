import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TxState {
  final double balance;
  final List<TransactionModel> tx;

  TxState({required this.balance, required this.tx});

  double get totalIncome => tx
      .where((t) => t.type == TransactionType.income)
      .fold<double>(0, (sum, t) => sum + t.amount);

  double get totalExpenses => tx
      .where((t) => t.type == TransactionType.expense)
      .fold<double>(0, (sum, t) => sum + t.amount);

  Map<String, double> get expenseByCategoryPercentage {
    final expenses =
        tx.where((t) => t.type == TransactionType.expense).toList();
    final total = totalExpenses;

    if (total == 0) return {};

    final Map<String, double> categoryTotals = {};

    for (var t in expenses) {
      if (t.category != null) {
        categoryTotals[t.category!] =
            (categoryTotals[t.category!] ?? 0) + t.amount;
      }
    }

    final Map<String, double> categoryPercentages = {};
    categoryTotals.forEach((category, amount) {
      categoryPercentages[category] = (amount / total) * 100;
    });

    return categoryPercentages;
  }

  Map<String, dynamic> toJson() => {
    'balance': balance,
    'tx': tx.map((e) => e.toJson()).toList(),
  };

  factory TxState.fromJson(Map<String, dynamic> json) => TxState(
    balance: json['balance'],
    tx: (json['tx'] as List).map((e) => TransactionModel.fromJson(e)).toList(),
  );

  TxState copyWith({double? balance, List<TransactionModel>? tx}) {
    return TxState(balance: balance ?? this.balance, tx: tx ?? this.tx);
  }
}

class TxNotifier extends StateNotifier<TxState> {
  TxNotifier() : super(TxState(balance: 0, tx: [])) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('tx_state');
    if (jsonString != null) {
      final map = jsonDecode(jsonString);
      state = TxState.fromJson(map);
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tx_state', jsonEncode(state.toJson()));
  }

  Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tx_state');
    state = TxState(balance: 0, tx: []);
  }

  void addTx(TransactionModel transaction) {
    if (transaction.type == TransactionType.income) {
      state = state.copyWith(
        tx: [...state.tx, transaction],
        balance: state.balance + transaction.amount,
      );
      _saveToPrefs();
    } else {
      state = state.copyWith(
        tx: [...state.tx, transaction],
        balance: state.balance - transaction.amount,
      );
      _saveToPrefs();
    }
  }
}

final txProvider = StateNotifierProvider<TxNotifier, TxState>((ref) {
  return TxNotifier();
});
