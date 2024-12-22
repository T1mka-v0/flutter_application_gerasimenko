import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './transaction_manager.dart';
import './transactions_add_page.dart';
import './income_add_page.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => TransactionsService(),
      child: const FinanceTrackerApp(),
    ));

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер финансов',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TransactionPage(),
    );
  }
}

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  TransactionPageState createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final transactionsService = Provider.of<TransactionsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Трекер финансов'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Income') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionsAddPage()));
              } else if (value == 'Expense') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IncomeAddPage()));
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Income',
                child: Text('Покупка'),
              ),
              const PopupMenuItem(
                value: 'Expense',
                child: Text('Доход'),
              ),
            ],
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Баланс: \$${transactionsService.totalBalance.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Text('Последние действия:'),
          Expanded(
            child: ListView.builder(
              itemCount: transactionsService.transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactionsService.transactions[index];
                return ListTile(
                  title: Text(transaction.description),
                  subtitle: Text(
                      '\$${transaction.amount.toStringAsFixed(2)} - ${transaction.date.toLocal().toString().split(' ')[0]} - ${transaction.category}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
