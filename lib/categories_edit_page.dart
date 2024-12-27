import 'package:flutter/material.dart';
import 'package:flutter_application_gerasimenko/transaction_manager.dart';
import 'package:provider/provider.dart';
import 'custom_text_field.dart';

class CategoriesEditPage extends StatefulWidget {
  const CategoriesEditPage({super.key});

  @override
  CategoriesEditPageState createState() => CategoriesEditPageState();
}

class CategoriesEditPageState extends State<CategoriesEditPage> {
  final categoryFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var transactionsService = Provider.of<TransactionsService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: customTextField(
                categoryFieldController, 'Введите название категории...')),
        ElevatedButton(
            onPressed: () {
              try {
                transactionsService.addCategory(categoryFieldController.text);
                categoryFieldController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: const Text('Добавить')),
        Expanded(
            child: ListView.builder(
          itemCount: transactionsService.expensesCategories.length,
          itemBuilder: (context, index) {
            var category = transactionsService.expensesCategories[index];
            return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            transactionsService.deleteCategory(category);
                          },
                          child: const Text('Удалить'))
                    ],
                  ),
                ));
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