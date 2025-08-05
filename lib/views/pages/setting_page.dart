import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
