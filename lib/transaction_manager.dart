import 'package:flutter/material.dart';

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

class Expense {
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  Expense(
      {required this.description,
      required this.amount,
      required this.date,
      required this.category});
}

class Income {
  final double amount;
  final DateTime date;

  Income({required this.amount, required this.date});
}

class TransactionsService extends ChangeNotifier {
  final List<Expense> expenses = [];
  final List<String> expensesCategories = [
    'Другое',
    'Продукты',
    'Рестораны',
    'Транспорт',
    'Развлечения',
    'Медицина',
  ];
  final List<Income> incomes = [];

  void addExpense(Expense transaction) {
    expenses.add(transaction);
    notifyListeners();
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
  }

  double get totalBalance =>
      incomes.fold(0.0, (sum, item) => sum + item.amount) -
      expenses.fold(0.0, (sum, item) => sum + item.amount);

  void addIncome(Income income) {
    incomes.add(Income(amount: income.amount, date: income.date));
    notifyListeners();
  }

  void deleteExpense(Expense expense) {
    expenses.remove(expense);
    notifyListeners();
  }

  void deleteIncome(Income income) {
    incomes.remove(income);
    notifyListeners();
  }

  void deleteCategory(String category) {
    expensesCategories.remove(category);
    notifyListeners();
  }
}
