import 'package:flutter/material.dart';
import 'package:mounthly_expenses/views/pages/balance_page.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  '3.000.000',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text('Rupiah', style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
