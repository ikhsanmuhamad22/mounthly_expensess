import 'package:flutter/material.dart';
import 'package:mounthly_expenses/data/local_storage_service.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/views/widgets/custom_fieldText.dart';

final storage = LocalStorageService();
final List<String> categories = [
  'Makanan',
  'Transportasi',
  'Belanja',
  'Hiburan',
  'Tagihan',
  'Kesehatan',
  'Lainnya',
];

class ModalAddExp extends StatefulWidget {
  const ModalAddExp({super.key});

  @override
  State<ModalAddExp> createState() => _ModalAddExpState();
}

class _ModalAddExpState extends State<ModalAddExp> {
  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  TextEditingController controllerDetail = TextEditingController();
  TextEditingController controllerAmount = TextEditingController();
  String selectedCategory = categories.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              height: 370,
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
                    CustomFieldtext(
                      title: 'Buat Apa ?',
                      controller: controllerDetail,
                    ),
                    CustomFieldtext(
                      title: 'Berapa ?',
                      controller: controllerAmount,
                    ),
                    SizedBox(height: 10),
                    custemSelectCategory(selectedCategory, (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }),
                    SizedBox(height: 10),
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
                            onPressed: () {
                              if (controllerDetail.text.isEmpty ||
                                  controllerAmount.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Harap isi detail dan nominal',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final newExpense = TransactionModel(
                                id: generateId(),
                                detail: controllerDetail.text,
                                amount:
                                    double.tryParse(controllerAmount.text) ??
                                    0.0,
                                category: selectedCategory,
                                date: DateTime.now(),
                                type: TransactionType.expense,
                              );
                              setState(() {
                                storage.saveTransaction(newExpense);
                                storage.subtractFromMainBalance(
                                  newExpense.amount,
                                );
                              });

                              Navigator.pop(context);
                            },
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

Widget custemSelectCategory(String category, void Function(String) onChanged) {
  return DropdownButtonFormField<String>(
    value: categories.first,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    items:
        categories.map((category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
    onChanged: (value) {
      if (value != null) {
        onChanged(value);
      }
    },
  );
}
