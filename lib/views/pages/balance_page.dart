import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/currency_provider.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/data/tx_provider.dart';
import 'package:mounthly_expenses/data/utils/formatter.dart';
import 'package:mounthly_expenses/views/widgets/expense_persentase_widget.dart';
import 'package:mounthly_expenses/views/widgets/modal_add_inc.dart';
import 'package:mounthly_expenses/views/widgets/modal_detail.dart';
import 'package:mounthly_expenses/views/widgets/pie_chart_widget.dart';

final List<String> categories = [
  'Makanan',
  'Transportasi',
  'Belanja',
  'Hiburan',
  'Tagihan',
  'Kesehatan',
  'Lainnya',
];

class BalancePage extends ConsumerWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<AnimatedCircularChartState> chartKey =
        GlobalKey<AnimatedCircularChartState>();

    var data = ref.watch(txProvider).tx;
    var totalExpense = ref.watch(txProvider).totalExpenses;
    var totalIncome = ref.watch(txProvider).totalIncome;
    var expenseByCategoryPercentage =
        ref.watch(txProvider).expenseByCategoryPercentage;
    var income = data.where((tx) => tx.type == TransactionType.income);
    final reverseIncome = income.toList().reversed.toList();
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Saldomu')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),

              child: Card(
                child: SizedBox(
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
                            'Detail Saldomu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total Pemasukan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currency == 'Rupiah'
                                        ? '+ ${formatRupiah.format(totalIncome)}'
                                        : '+ ${formatDollar.format(totalIncome)}',
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Total Pengeluaran',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currency == 'Rupiah'
                                        ? '- ${formatRupiah.format(totalExpense)}'
                                        : '- ${formatDollar.format(totalExpense)}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            expenseByCategoryPercentage.isEmpty
                                ? Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      child: Text('Kosong'),
                                    ),
                                  ),
                                )
                                : Expanded(
                                  flex: 5,
                                  child: PieChartWidget(
                                    chartKey: chartKey,
                                    data: expenseByCategoryPercentage,
                                  ),
                                ),
                            Expanded(
                              flex: 5,
                              child: ExpensePersentaseWidget(
                                data: expenseByCategoryPercentage,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History isi saldo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  ModalAddIncome(),
                ],
              ),
            ),
            income.isEmpty
                ? Expanded(child: Center(child: Text('Belum ada riwayat')))
                : Expanded(
                  child: ListView.builder(
                    itemCount: income.length,
                    itemBuilder: (context, index) {
                      var transaction = reverseIncome[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ModalDetail(
                          transactions: transaction,
                          type: TransactionType.income,
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
