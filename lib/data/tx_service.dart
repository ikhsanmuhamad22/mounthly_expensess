import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/data/utils/dummy_data.dart';

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

  TxState copyWith({double? balance, List<TransactionModel>? tx}) {
    return TxState(balance: balance ?? this.balance, tx: tx ?? this.tx);
  }
}

class TxNotifier extends StateNotifier<TxState> {
  TxNotifier() : super(TxState(balance: 0, tx: []));

  void addTx(TransactionModel transaction) {
    if (transaction.type == TransactionType.income) {
      state = state.copyWith(
        tx: [...state.tx, transaction],
        balance: state.balance + transaction.amount,
      );
    } else {
      state = state.copyWith(
        tx: [...state.tx, transaction],
        balance: state.balance - transaction.amount,
      );
    }
  }
}

final txProvider = StateNotifierProvider<TxNotifier, TxState>((ref) {
  return TxNotifier();
});
