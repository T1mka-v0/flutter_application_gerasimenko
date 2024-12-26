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

class Income {
  final double amount;
  final DateTime date;

  Income({required this.amount, required this.date});
}

class TransactionsService extends ChangeNotifier {
  final List<Transaction> transactions = [];
  final List<String> transactionCategories = [
    'Продукты',
    'Рестораны',
    'Транспорт',
    'Развлечения',
    'Медицина',
    'Другое'
  ];
  final List<Income> incomes = [];

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  void addCategory(String newCategory) {
    for (var category in transactionCategories) {
      if (newCategory.toLowerCase() == category.toLowerCase()) {
        throw CustomCategoryException(
            'Категория "$newCategory" уже существует!');
      }
    }
    transactionCategories.add(capitalize(newCategory));
    notifyListeners();
  }

  double get totalBalance =>
      incomes.fold(0.0, (sum, item) => sum + item.amount) -
      transactions.fold(0.0, (sum, item) => sum + item.amount);

  void addIncome(Income income) {
    incomes.add(Income(amount: income.amount, date: income.date));
    notifyListeners();
  }
}
