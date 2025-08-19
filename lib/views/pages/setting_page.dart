import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mounthly_expenses/data/currency_provider.dart';
import 'package:mounthly_expenses/data/theme_provider.dart';
import 'package:mounthly_expenses/data/tx_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCurrency = ref.watch(currencyProvider);
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('Pilih tema anda')),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                              themes.map((t) {
                                return Row(
                                  children: [
                                    Radio.adaptive(
                                      value: t,
                                      groupValue: ref.watch(themeProvider),
                                      onChanged: (value) {
                                        if (value != null) {
                                          ref
                                              .read(themeProvider.notifier)
                                              .setTheme(value);
                                        }
                                      },
                                    ),
                                    Text(t.name),
                                  ],
                                );
                              }).toList(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
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
            ListTile(
              title: Text('Mata uang'),
              leading: Icon(Icons.attach_money),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(child: Text('Pilih Mata uang')),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            children:
                                currency.map((c) {
                                  return Row(
                                    children: [
                                      Radio<String>.adaptive(
                                        value: c,
                                        groupValue: selectedCurrency,
                                        onChanged: (value) {
                                          if (value != null) {
                                            ref
                                                .read(currencyProvider.notifier)
                                                .setCurrency(value);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text(c),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
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
