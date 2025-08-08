import 'package:flutter/material.dart';
import 'package:mounthly_expenses/data/models/tx_model.dart';
import 'package:mounthly_expenses/main.dart';
import 'package:mounthly_expenses/views/widgets/custom_fieldText.dart';

class ModalAddIncome extends StatefulWidget {
  const ModalAddIncome({super.key});

  @override
  State<ModalAddIncome> createState() => _ModalAddIncomeState();
}

class _ModalAddIncomeState extends State<ModalAddIncome> {
  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  TextEditingController controllerAmount = TextEditingController();
  TextEditingController controllerDetail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              height: 350,
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
                        'Tambah Saldo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomFieldtext(
                      title: 'Berapa',
                      controller: controllerAmount,
                    ),
                    CustomFieldtext(
                      title: 'Dari apa',
                      controller: controllerDetail,
                    ),
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
                              if (controllerAmount.text.isEmpty ||
                                  controllerDetail.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Harap isi jumlah yang mau diisi',
                                    ),
                                  ),
                                );
                                return;
                              }
                              final newIncome = TransactionModel(
                                id: generateId(),
                                detail: controllerDetail.text,
                                amount:
                                    double.tryParse(controllerAmount.text) ??
                                    0.0,
                                date: DateTime.now(),
                                type: TransactionType.income,
                              );

                              setState(() {
                                storage.saveTransaction(newIncome);
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
    );
  }
}
