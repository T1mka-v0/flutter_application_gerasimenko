import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'transaction_manager.g.dart';

String capitalize(String str) {
  if (str.isEmpty) return '';

  return '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}';
}

class CustomCategoryException implements Exception {
  final String message;
  CustomCategoryException(this.message);

  @override
  String toString() => message;
}

@HiveType(typeId: 1)
class Expense extends HiveObject {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String category;

  Expense({
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}

@HiveType(typeId: 2)
class Income extends HiveObject {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final DateTime date;

  Income({
    required this.amount,
    required this.date,
  });
}

@HiveType(typeId: 0)
class TransactionsService extends HiveObject with ChangeNotifier {
  @HiveField(0)
  final List<Expense> expenses = [];

  @HiveField(1)
  final List<String> expensesCategories = [
    'Другое',
    'Продукты',
    'Рестораны',
    'Транспорт',
    'Развлечения',
    'Медицина',
  ];

  @HiveField(2)
  final List<Income> incomes = [];

  void addExpense(Expense transaction) {
    expenses.add(transaction);
    notifyListeners();
    Hive.box<TransactionsService>('transactions').put('service', this);
    save();
    // print(
    //     '!!!!!!!!!!!!!!!!!!!!!!! ${expenses[0].description}!!!!!!!!!!!!!!!!!!!!!!!!');
  }

  void addCategory(String newCategory) {
    for (var category in expensesCategories) {
      if (newCategory.toLowerCase() == category.toLowerCase()) {
        throw CustomCategoryException(
            'Категория "$newCategory" уже существует!');
      }
    }
    expensesCategories.add(capitalize(newCategory));
    notifyListeners();
    Hive.box<TransactionsService>('transactions').put('service', this);
    save();
  }

  double get totalBalance =>
      incomes.fold(0.0, (sum, item) => sum + item.amount) -
      expenses.fold(0.0, (sum, item) => sum + item.amount);

  void addIncome(Income income) {
    incomes.add(Income(amount: income.amount, date: income.date));
    notifyListeners();
    Hive.box<TransactionsService>('transactions').put('service', this);
    save();
  }

  void deleteExpense(Expense expense) {
    expenses.remove(expense);
    notifyListeners();
    Hive.box<TransactionsService>('transactions').put('service', this);
    save();
  }

  void deleteIncome(Income income) {
    incomes.remove(income);
    notifyListeners();
    Hive.box<TransactionsService>('transactions').put('service', this);
    save();
  }

  void deleteCategory(String category) {
    if (category == 'Другое') {
      return;
    }
    expensesCategories.remove(category);
    notifyListeners();
    Hive.box<TransactionsService>('transactions').put('service', this);
    save();
  }
}
