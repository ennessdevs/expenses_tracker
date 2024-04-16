import 'package:equatable/equatable.dart';
import 'package:expenses_tracker/core/enums/transaction_type.dart';

class Expense extends Equatable {
  final int index;
  final double amount;
  final DateTime date;
  final String description;
  final double totalAmount;
  final TransactionType transactionType;

  const Expense({
    required this.index,
    required this.amount,
    required this.date,
    required this.description,
    required this.totalAmount,
    required this.transactionType,
  });

  @override
  List<Object?> get props =>
      [index, amount, date, description, totalAmount, transactionType];
}
