import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/data/tx_service.dart';
import 'package:mounthly_expenses/data/utils/formatter.dart';
import 'package:mounthly_expenses/views/widgets/modal_add_income.dart';
import 'package:mounthly_expenses/views/widgets/modal_detail_exp.dart';

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
                                    '+ ${formatCurrency.format(totalIncome)}',
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
                                    '- ${formatCurrency.format(totalExpense)}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            pieChart(
                              chartKey: chartKey,
                              data: expenseByCategoryPercentage,
                            ),
                            detailPersentase(data: expenseByCategoryPercentage),
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
                ? Expanded(child: Center(child: Text('Belum ada transaksi')))
                : Expanded(
                  child: ListView.builder(
                    itemCount: income.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ModalDetailExp(
                          transactions: income.elementAt(index),
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

Widget pieChart({chartKey, data}) {
  if (data.isEmpty || data.values.every((value) => value == 0)) {
    data = {
      'Makanan': 0.0,
      'Transportasi': 0.0,
      'Belanja': 0.0,
      'Hiburan': 0.0,
      'Tagihan': 0.0,
      'Kesehatan': 0.0,
      'Lainnya': 0.0,
      'Kosong': 100.0,
    };
  }

  return Center(
    child: Column(
      children: [
        AnimatedCircularChart(
          key: chartKey,
          size: Size(150.0, 150.0),
          initialChartData: <CircularStackEntry>[
            CircularStackEntry(<CircularSegmentEntry>[
              CircularSegmentEntry(
                data['Makanan'] ?? 0,
                Colors.red,
                rankKey: 'Q1',
              ),
              CircularSegmentEntry(
                data['Transportasi'] ?? 0,

                Colors.green,
                rankKey: 'Q2',
              ),
              CircularSegmentEntry(
                data['Belanja'] ?? 0,

                Colors.blue,
                rankKey: 'Q3',
              ),
              CircularSegmentEntry(
                data['Hiburan'] ?? 0,

                Colors.yellow,
                rankKey: 'Q4',
              ),
              CircularSegmentEntry(
                data['Tagihan'] ?? 0,

                Colors.grey,
                rankKey: 'Q5',
              ),
              CircularSegmentEntry(
                data['Kesehatan'] ?? 0,
                Colors.teal,
                rankKey: 'Q6',
              ),
              CircularSegmentEntry(
                data['Lainnya'] ?? 0,
                Colors.purple,
                rankKey: 'Q7',
              ),
              CircularSegmentEntry(
                data['Kosong'] ?? 0,
                Colors.transparent,
                rankKey: 'Q7',
              ),
            ], rankKey: 'quarterly'),
          ],
          chartType: CircularChartType.Pie,
        ),
      ],
    ),
  );
}

Widget detailPersentase({data}) {
  return Expanded(
    flex: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 150,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Makanan'),
                    ],
                  ),
                  Text(
                    '${data['Makanan'] != null ? data['Makanan']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Transportasi'),
                    ],
                  ),
                  Text(
                    '${data['Transportasi'] != null ? data['Transportasi']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Belanja'),
                    ],
                  ),
                  Text(
                    '${data['Belanja'] != null ? data['Belanja']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.yellow),
                      SizedBox(width: 10),
                      Text('Hiburan'),
                    ],
                  ),
                  Text(
                    '${data['Hiburan'] != null ? data['Hiburan']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('Tagihan'),
                    ],
                  ),
                  Text(
                    '${data['Tagihan'] != null ? data['Tagihan']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.teal),
                      SizedBox(width: 10),
                      Text('Kesehatan'),
                    ],
                  ),
                  Text(
                    '${data['Kesehatan'] != null ? data['Kesehatan']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: Colors.purple),
                      SizedBox(width: 10),
                      Text('Lainnya'),
                    ],
                  ),
                  Text(
                    '${data['Lainnya'] != null ? data['Lainnya']!.toStringAsFixed(1) : 0} %',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
