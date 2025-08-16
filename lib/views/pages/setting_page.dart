import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/tx_service.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ListTile(
              title: Text('Tema'),
              leading: Icon(Icons.area_chart_sharp),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
            ),
            ListTile(
              title: Text('Mata uang'),
              leading: Icon(Icons.attach_money),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
            ),
            ListTile(
              title: Text('Reset Data'),
              leading: Icon(Icons.restore),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Apakah Kamu yakin'),
                        content: Text(
                          'Semua data kamu akan hilang ketika kamu meresetnya',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              ref.read(txProvider.notifier).clearStorage();
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
