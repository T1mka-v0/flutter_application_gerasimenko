import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/custom_text_field.dart';
import './transaction_manager.dart';
import 'package:provider/provider.dart';

class IncomeAddPage extends StatefulWidget {
  const IncomeAddPage({super.key});

  @override
  IncomeAddPageState createState() => IncomeAddPageState();
}

class IncomeAddPageState extends State<IncomeAddPage> {
  final _amountController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final transactionsService = Provider.of<TransactionsService>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: customTextField(_amountController, 'Введите сумму...',
                numerical: true),
          ),
          ElevatedButton(
              onPressed: () {
                double? amount;
                if (_amountController.text.isNotEmpty) {
                  amount = double.tryParse(_amountController.text);
                }
                if (amount != null) {
                  transactionsService
                      .addIncome(Income(amount: amount, date: DateTime.now()));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Доход добавлен!'),
                    duration: Duration(seconds: 1),
                  ));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Сумма введена неправильно!'),
                    duration: Duration(seconds: 1),
                  ));
                }
              },
              child: const Text('Add'))
        ],
      ),
    );
  }
}
