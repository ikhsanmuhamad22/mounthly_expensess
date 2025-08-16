import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpensePersentaseWidget extends StatelessWidget {
  const ExpensePersentaseWidget({super.key, required this.data});

  final data;

  @override
  Widget build(BuildContext context) {
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
}
