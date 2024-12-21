import 'package:flutter/material.dart';

void main() => runApp(FinanceTrackerApp());

class FinanceTrackerApp extends StatelessWidget {
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
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final List<Transaction> _transactions = [];
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Другое';
  final List<String> _categories = ['Еда', 'Тарнспорт', 'Рестораны', 'Другое'];

  void _addTransaction(String type) {
    final amountText = _amountController.text;
    final description = _descriptionController.text;

    if (amountText.isEmpty || description.isEmpty) return;

    final amount = double.tryParse(amountText);
    if (amount == null) return;

    setState(() {
      _transactions.add(Transaction(
        description: description,
        amount: type == 'Expense' ? -amount : amount,
        date: DateTime.now(),
        category: _selectedCategory,
      ));
    });

    _amountController.clear();
    _descriptionController.clear();
  }

  double get _totalBalance =>
      _transactions.fold(0.0, (sum, item) => sum - item.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Трекер финансов'),
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
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      child: Center(
                        child: Text('Ghdbtn'),
                      ),
                    );
                  },
                );
              } else if (value == 'Expense') {
                _addTransaction('Expense');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Income',
                child: Text('Покупка'),
              ),
              PopupMenuItem(
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
                Text('Баланс: \$${_totalBalance.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _addTransaction('Expense');
                  },
                  child: Text('Add Transaction'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
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

class Transaction {
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  Transaction(
      {required this.description,
      required this.amount,
      required this.date,
      required this.category});
}
