import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/data/tx_service.dart';
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
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Text(
                                    '3.000.000',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  pieChart(chartKey),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      itemCount: categories.length,
                                      itemBuilder: (contextt, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(categories[index]),
                                            Text('50%'),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
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

Widget pieChart(chartKey) {
  return Center(
    child: Column(
      children: [
        AnimatedCircularChart(
          key: chartKey,
          size: Size(150.0, 150.0),
          initialChartData: <CircularStackEntry>[
            CircularStackEntry(<CircularSegmentEntry>[
              CircularSegmentEntry(25.0, Colors.red, rankKey: 'Q1'),
              CircularSegmentEntry(25.0, Colors.green, rankKey: 'Q2'),
              CircularSegmentEntry(25.0, Colors.blue, rankKey: 'Q3'),
              CircularSegmentEntry(25.0, Colors.yellow, rankKey: 'Q4'),
            ], rankKey: 'quarterly'),
          ],
          chartType: CircularChartType.Pie,
        ),
      ],
    ),
  );
}
