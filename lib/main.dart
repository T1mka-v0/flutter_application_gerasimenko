import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/expenses_show_page.dart';
import 'package:flutter_application_gerasimenko/incomes_show_page.dart';
import 'package:provider/provider.dart';
import './transaction_manager.dart';
import './transactions_add_page.dart';
import './income_add_page.dart';
import './categories_edit_page.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => TransactionsService(),
      child: const FinanceTrackerApp(),
    ));

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(useMaterial3: true, colorScheme: const ColorScheme.light()),
      darkTheme:
          ThemeData(useMaterial3: true, colorScheme: const ColorScheme.dark()),
      home: const FinanceTrackerHomePage(),
      title: 'Трекер Финансов',
    );
  }
}

class FinanceTrackerHomePage extends StatelessWidget {
  const FinanceTrackerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Трекер финансов'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoriesEditPage()));
              },
            ),
          ],
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
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Consumer<TransactionsService>(
                  builder: (_, transactionsService, __) {
                return Text(
                    'Баланс: ${transactionsService.totalBalance.toStringAsFixed(2)}');
              }),
              bottom: const TabBar(tabs: [
                Tab(
                  text: 'Покупки',
                ),
                Tab(
                  text: 'Поступления',
                )
              ]),
            ),
            body: const TabBarView(children: [
              ExpensesShowPage(),
              IncomesShowPage(),
            ]),
          ),
        ));
  }
}
