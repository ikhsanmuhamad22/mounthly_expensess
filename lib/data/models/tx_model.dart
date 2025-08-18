enum TransactionType { income, expense }

class TransactionModel {
  final String id;
  final double amount;
  final String detail;
  final DateTime date;
  final String? category;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.detail,
    required this.date,
    this.category,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      detail: json['detail'],
      date: DateTime.parse(json['date']),
      category: json['category'],
      type:
          json['type'] == 'income'
              ? TransactionType.income
              : TransactionType.expense,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'detail': detail,
      'date': date.toIso8601String(),
      'category': category,
      'type': type == TransactionType.income ? 'income' : 'expense',
    };
  }
}
