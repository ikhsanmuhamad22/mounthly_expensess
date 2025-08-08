import 'dart:convert';
import 'package:mounthly_expenses/data/models/main_balance_model.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _transactionsKey = 'transactions';
  static const _balanceKey = 'main_balance';

  void saveTransaction(TransactionModel transaction) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingData = prefs.getStringList('transactions') ?? [];
    existingData.add(jsonEncode(transaction.toJson()));
    await prefs.setStringList('transactions', existingData);
  }

  Future<List<TransactionModel>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(_transactionsKey);

    if (stringList == null) return [];

    return stringList
        .map((jsonString) => TransactionModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  Future<void> saveMainBalance(MainBalance balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_balanceKey, jsonEncode(balance.toJson()));
  }

  Future<MainBalance> loadMainBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_balanceKey);

    if (jsonString == null) {
      return MainBalance(totalIncome: 0, totalExpense: 0);
    }

    final Map<String, dynamic> decoded = jsonDecode(jsonString);
    return MainBalance.fromJson(decoded);
  }
}
