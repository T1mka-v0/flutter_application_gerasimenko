// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_manager.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 1;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      description: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      category: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IncomeAdapter extends TypeAdapter<Income> {
  @override
  final int typeId = 2;

  @override
  Income read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Income(
      amount: fields[0] as double,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Income obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionsServiceAdapter extends TypeAdapter<TransactionsService> {
  @override
  final int typeId = 0;

  @override
  TransactionsService read(BinaryReader reader) {
    return TransactionsService();
  }

  @override
  void write(BinaryWriter writer, TransactionsService obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.expenses)
      ..writeByte(1)
      ..write(obj.expensesCategories)
      ..writeByte(2)
      ..write(obj.incomes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
