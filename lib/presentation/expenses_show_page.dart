import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/data/transaction_manager.dart';
import 'package:provider/provider.dart';
import 'expense_card.dart';

class ExpensesShowPage extends StatelessWidget {
  const ExpensesShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsService>(builder: (_, transactionsService, __) {
      return ListView.builder(
        itemCount: transactionsService.expenses.length,
        itemBuilder: (context, index) {
          final expense = transactionsService.expenses[index];
          return ExpenseCard(
            expense: expense,
            onDelete: () => transactionsService.deleteExpense(expense),
          );
        },
      );
    });
  }
}
