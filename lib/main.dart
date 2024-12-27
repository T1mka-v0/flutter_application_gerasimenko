import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/presentation/expenses_add_page.dart';
import 'package:flutter_application_gerasimenko/presentation/expenses_show_page.dart';
import 'package:flutter_application_gerasimenko/presentation/income_add_page.dart';
import 'package:flutter_application_gerasimenko/presentation/incomes_show_page.dart';
import 'package:provider/provider.dart';
import 'data/transaction_manager.dart';
import 'presentation/categories_edit_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionsServiceAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());

  var box = await Hive.openBox<TransactionsService>('transactions');
  var transactions = box.get('service') ?? TransactionsService();

  runApp(ChangeNotifierProvider(
    create: (context) => transactions,
    child: const FinanceTrackerApp(),
  ));
}

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

class FinanceTrackerHomePage extends StatefulWidget {
  const FinanceTrackerHomePage({super.key});

  @override
  State<FinanceTrackerHomePage> createState() => FinanceTrackerHomePageState();
}

class FinanceTrackerHomePageState extends State<FinanceTrackerHomePage> {
  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void dispose() {
    Hive.box('transactions').compact();
    Hive.box('transactions').close();
    super.dispose();
  }

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
        floatingActionButton: SpeedDial(
          onPress: () => setState(() {
            isDialOpen.value = !isDialOpen.value;
          }),
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          mini: false,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          label: null,
          activeLabel: null,
          renderOverlay: true,
          useRotationAnimation: true,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          shape: const StadiumBorder(),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.shopping_bag),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Покупка',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExpensesAddPage())),
            ),
            SpeedDialChild(
              child: const Icon(Icons.money),
              backgroundColor: const Color.fromARGB(255, 19, 168, 96),
              foregroundColor: Colors.white,
              label: 'Доход',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IncomeAddPage())),
            ),
          ],
        ),
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
                  text: 'Доходы',
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
