import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';

class TxState {
  final double balance;
  final List<TransactionModel> tx;

  TxState({required this.balance, required this.tx});

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
