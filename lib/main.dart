import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/expenses_add_page.dart';
import 'package:flutter_application_gerasimenko/expenses_show_page.dart';
import 'package:flutter_application_gerasimenko/income_add_page.dart';
import 'package:flutter_application_gerasimenko/incomes_show_page.dart';
import 'package:provider/provider.dart';
import './transaction_manager.dart';
import './categories_edit_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

class FinanceTrackerHomePage extends StatefulWidget {
  const FinanceTrackerHomePage({super.key});

  @override
  State<FinanceTrackerHomePage> createState() => FinanceTrackerHomePageState();
}

class FinanceTrackerHomePageState extends State<FinanceTrackerHomePage> {
  var isDialOpen = ValueNotifier<bool>(false);

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
          // animatedIcon: AnimatedIcons.menu_close,
          // animatedIconTheme: IconThemeData(size: 22.0),
          // / This is ignored if animatedIcon is non null
          // child: Text("open"),
          // activeChild: Text("close"),
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          mini: false,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          label: null,

          /// The active label of the main button, Defaults to label if not specified.
          activeLabel: null,
          renderOverlay: true,
          // overlayColor: Colors.black,
          // overlayOpacity: 0.5,
          useRotationAnimation: true,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          // foregroundColor: Colors.black,
          // backgroundColor: Colors.white,
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
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
              label: 'Получка',
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
