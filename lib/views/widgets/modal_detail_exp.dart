import 'package:flutter/material.dart';

class ModailDetailExp extends StatelessWidget {
  const ModailDetailExp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              height: 280,
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
                        'Detail Pengeluaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Beli seblak', style: TextStyle(fontSize: 16)),
                          Text('selasa 05 2005'),
                        ],
                      ),
                    ),
                    Text('-10.000', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                          style: ButtonStyle(),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: ListTile(
        title: Text('jajan seblak'),
        leading: Icon(Icons.folder_outlined),
        trailing: Text('-20.000'),
      ),
    );
  }
}
