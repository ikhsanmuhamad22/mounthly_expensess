import 'package:flutter/material.dart';
import 'package:mounthly_expenses/views/pages/setting_page.dart';
import 'package:mounthly_expenses/views/widgets/balance_card_widget.dart';
import 'package:mounthly_expenses/views/widgets/modal_detail_exp.dart';
import 'package:mounthly_expenses/views/widgets/modal_add_exp.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('keuanganmu'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            BalanceCardWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengeluaranmu',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  ModalAddExp(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ModalDetailExp(),
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
