import 'package:flutter/material.dart';

class ModalAddExp extends StatelessWidget {
  const ModalAddExp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tambah Pengeluaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    customFieldText('Buat Apa ?'),
                    customFieldText('Berapa ?'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 5,
                          child: FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Close'),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 5,
                          child: FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Submit'),
                          ),
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
      child: Icon(Icons.add),
    );
  }
}

Widget customFieldText(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextField(
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(
          fontFamily: 'IndieFlower', // Gaya tulisan tangan
          fontSize: 18,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    ),
  );
}
