class MainBalance {
  double amount;

  MainBalance({required this.amount});

  Map<String, dynamic> toJson() => {'amount': amount};

  factory MainBalance.fromJson(Map<String, dynamic> json) {
    return MainBalance(amount: json['amount']);
  }
}
