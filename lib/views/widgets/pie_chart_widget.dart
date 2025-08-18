import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  PieChartWidget({super.key, required this.chartKey, required this.data});

  final chartKey;
  final data;

  @override
  Widget build(BuildContext context) {
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
}
