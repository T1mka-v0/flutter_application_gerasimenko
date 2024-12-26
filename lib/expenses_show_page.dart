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
          itemCount: transactionsService.incomes.length,
          itemBuilder: (context, index) {
            final income = transactionsService.incomes[index];
            return ListTile(
              title: Text(
                  'Сумма: ${income.amount.toStringAsFixed(2)}\nДата операции: ${income.date.day}.${income.date.month}.${income.date.year}'),
            );
          },
        ),
      );
    });
  }
}
