import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/presentation/custom_text_field.dart';
import '../data/transaction_manager.dart';
import 'package:provider/provider.dart';

class ExpensesAddPage extends StatefulWidget {
  const ExpensesAddPage({super.key});

  @override
  ExpensesAddPageState createState() => ExpensesAddPageState();
}

class ExpensesAddPageState extends State<ExpensesAddPage> {
  final _amountController = TextEditingController(text: '0');
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Другое';

  @override
  Widget build(BuildContext context) {
    final transactionsService = Provider.of<TransactionsService>(context);
    var categories = transactionsService.expensesCategories;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: customTextField(
                  _descriptionController, 'Введите описание...')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: customTextField(_amountController, 'Введите сумму...',
                numerical: true),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Категория: '),
              DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList()),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                double? amount;
                if (_amountController.text.isNotEmpty) {
                  amount = double.tryParse(_amountController.text);
                }
                if (amount != null) {
                  transactionsService.addExpense(Expense(
                      description: _descriptionController.text,
                      amount: double.parse(_amountController.text),
                      date: DateTime.now(),
                      category: _selectedCategory));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Покупка добавлена!'),
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
