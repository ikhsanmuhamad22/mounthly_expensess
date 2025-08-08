class MainBalance {
  double totalIncome;
  double totalExpense;

  MainBalance({required this.totalIncome, required this.totalExpense});

  double get balance => totalIncome - totalExpense;

  factory MainBalance.fromJson(Map<String, dynamic> json) {
    return MainBalance(
      totalIncome: (json['totalIncome'] as num).toDouble(),
      totalExpense: (json['totalExpense'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'totalIncome': totalIncome, 'totalExpense': totalExpense};
  }
}
