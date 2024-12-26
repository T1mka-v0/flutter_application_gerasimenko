import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/transaction_manager.dart';
import 'package:provider/provider.dart';

class CategoriesEditPage extends StatefulWidget {
  const CategoriesEditPage({super.key});

  @override
  CategoriesEditPageState createState() => CategoriesEditPageState();
}

class CategoriesEditPageState extends State<CategoriesEditPage> {
  final categoryFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final transactionsService = Provider.of<TransactionsService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          controller: categoryFieldController,
          decoration: const InputDecoration(labelText: 'Название категории'),
        ),
        TextButton.icon(
            onPressed: () {
              try {
                transactionsService.addCategory(categoryFieldController.text);
                categoryFieldController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            label: const Text('Создать категорию')),
        Expanded(
            child: ListView.builder(
          itemCount: transactionsService.transactionCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(transactionsService.transactionCategories[index]));
          },
        ))
      ]),
    );
  }
}
// class CategoriesEditPageState extends State<CategoriesEditPage> {
  
// }

// List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Draggable List')),
  //     body: DragAndDropList<String>(
  //       items,
  //       itemBuilder: (context, item) => ListTile(title: Text(item)),
  //       onDragFinish: (before, after) {
  //         String data = items[before];
  //         items.removeAt(before);
  //         items.insert(after, data);
  //       },
  //       canBeDraggedTo: (one, two) => true,
  //     ),
  //   );
  // }