import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/presentation/income_card.dart';
import 'package:flutter_application_gerasimenko/data/transaction_manager.dart';
import 'package:provider/provider.dart';

class IncomesShowPage extends StatelessWidget {
  const IncomesShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionsService>(builder: (_, transactionsService, __) {
      return ListView.builder(
        itemCount: transactionsService.incomes.length,
        itemBuilder: (context, index) {
          final income = transactionsService.incomes[index];
          return IncomeCard(
            income: income,
            onDelete: () => transactionsService.deleteIncome(income),
          );
        },
      );
    });
  }
}
