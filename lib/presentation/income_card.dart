import 'package:flutter/material.dart';
import '../data/transaction_manager.dart';

class IncomeCard extends StatelessWidget {
  final Income income;
  final VoidCallback onDelete;

  const IncomeCard({super.key, required this.income, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${income.date.day}.${income.date.month}.${income.date.year}',
                ),
                Text(
                  '\$${income.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[400],
                  ),
                ),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.delete))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
