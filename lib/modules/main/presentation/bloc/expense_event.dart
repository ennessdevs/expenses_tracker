part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class ExpenseAdd extends ExpenseEvent {
  final int index;
  final double amount;
  final DateTime date;
  final String description;
  final TransactionType transactionType;

  ExpenseAdd({
    required this.index,
    required this.amount,
    required this.date,
    required this.description,
    required this.transactionType,
  });
}

final class ExpenseUpdate extends ExpenseEvent {
  final double? amount;
  final DateTime? date;
  final String? description;
  final TransactionType? transactionType;
  final double? totalAmount;

  ExpenseUpdate({
    this.transactionType,
    this.totalAmount,
    this.amount,
    this.date,
    this.description,
  });
}

final class ExpenseDelete extends ExpenseEvent {
  final int index;

  ExpenseDelete({required this.index});
}

final class ExpenseFetchAllExpenses extends ExpenseEvent {}
