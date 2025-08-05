import 'package:flutter/material.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 150,
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
                          color: Colors.white60,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                ),
                Text(
                  '3.000.000',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text('Rupiah', style: TextStyle(color: Colors.white54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
