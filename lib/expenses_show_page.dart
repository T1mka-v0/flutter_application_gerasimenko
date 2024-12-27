import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/transaction_manager.dart';
import 'package:provider/provider.dart';

class ExpensesShowPage extends StatelessWidget {
  const ExpensesShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsService>(builder: (_, transactionsService, __) {
      return Expanded(
        child: ListView.builder(
          itemCount: transactionsService.expenses.length,
          itemBuilder: (context, index) {
            final expense = transactionsService.expenses[index];
            return ListTile(
              title: Text(expense.description),
              subtitle: Text(
                  'Сумма: ${expense.amount.toStringAsFixed(2)}\nДата операции: ${expense.date.day}.${expense.date.month}.${expense.date.year}\nКатегория: ${expense.category}'),
            );
          },
        ),
      );
    });
  }
}
