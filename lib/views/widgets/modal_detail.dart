import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/currency_provider.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/data/utils/formatter.dart';

class ModalDetail extends ConsumerWidget {
  const ModalDetail({
    super.key,
    required this.transactions,
    required this.type,
  });

  final TransactionModel transactions;
  final TransactionType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyProvider);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(timeFormat.format(transactions.date)),
                              Text(
                                dateFormat.format(transactions.date),
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      currency == 'Rupiah'
                          ? type == TransactionType.expense
                              ? '- ${formatRupiah.format(transactions.amount)}'
                              : '+ ${formatRupiah.format(transactions.amount)}'
                          : type == TransactionType.expense
                          ? '- ${formatDollar.format(transactions.amount)}'
                          : '+ ${formatDollar.format(transactions.amount)}',
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
              ? '- ${currency == 'Rupiah' ? formatRupiah.format(transactions.amount) : formatDollar.format(transactions.amount)}'
              : '+ ${currency == 'Rupiah' ? formatRupiah.format(transactions.amount) : formatDollar.format(transactions.amount)}',
        ),
      ),
    );
  }
}
