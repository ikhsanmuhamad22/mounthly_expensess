import 'dart:convert';
import 'package:mounthly_expenses/data/models/main_balance_model.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _transactionsKey = 'transactions';
  static const _balanceKey = 'main_balance';

  Future<void> saveTransaction(TransactionModel transaction) async {
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
      return MainBalance(amount: 0); // Default awal
    }

    final jsonData = jsonDecode(jsonString);
    return MainBalance.fromJson(jsonData);
  }

  Future<void> addToMainBalance(double value) async {
    MainBalance currentBalance = await loadMainBalance();
    currentBalance.amount += value;
    await saveMainBalance(currentBalance);
  }

  Future<void> subtractFromMainBalance(double value) async {
    MainBalance currentBalance = await loadMainBalance();
    currentBalance.amount -= value;
    await saveMainBalance(currentBalance);
  }
}
