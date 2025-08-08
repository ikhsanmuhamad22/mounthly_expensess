import 'package:flutter/material.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/data/utils/formatter.dart';

class ModalDetailExp extends StatelessWidget {
  const ModalDetailExp({
    super.key,
    required this.transactions,
    required this.type,
  });

  final TransactionModel transactions;
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              height: 280,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Detail Pengeluaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transactions.detail,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(transactions.date.timeZoneName),
                        ],
                      ),
                    ),
                    Text(
                      '- ${formatCurrency.format(transactions.amount)}',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                          style: ButtonStyle(),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: ListTile(
        title: Text(transactions.detail),
        leading: Icon(Icons.folder_outlined),
        trailing: Text(
          type == TransactionType.expense
              ? '- ${formatCurrency.format(transactions.amount)}'
              : '+ ${formatCurrency.format(transactions.amount)}',
        ),
      ),
    );
  }
}
