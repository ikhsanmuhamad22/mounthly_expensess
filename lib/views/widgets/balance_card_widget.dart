import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/currency_provider.dart';
import 'package:mounthly_expenses/data/tx_provider.dart';
import 'package:mounthly_expenses/data/utils/formatter.dart';
import 'package:mounthly_expenses/views/pages/balance_page.dart';

class BalanceCardWidget extends ConsumerWidget {
  const BalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var balance = ref.watch(txProvider).balance.toString();
    final currency = ref.watch(currencyProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saldo mu',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_chart),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BalancePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Text(
                  currency == 'Rupiah'
                      ? formatRupiah.format(double.parse(balance))
                      : formatDollar.format(double.parse(balance)),
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),

                Text(
                  currency == 'Rupiah' ? 'Rupiah' : 'Us Dollar',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
