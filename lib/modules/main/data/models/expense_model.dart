import 'package:expenses_tracker/core/enums/transaction_type.dart';
import 'package:expenses_tracker/modules/main/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.index,
    required super.amount,
    required super.date,
    required super.description,
    required super.transactionType,
    required super.totalAmount,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic>? data) {
    if (data == null) {
      throw Exception();
    }
    return ExpenseModel(
      index: data['index'] as int,
      amount: data['amount'] as double,
      date:
          data['date'] == null ? DateTime.now() : DateTime.parse(data['date']),
      description: data['description'] as String,
      transactionType: data['transaction_type'] as TransactionType,
      totalAmount: data['total_amount'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'index': index,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'transaction_type': transactionType,
      'total_amount': totalAmount,
    };
  }

  ExpenseModel copyWith({
    int? index,
    double? amount,
    DateTime? date,
    String? description,
    double? totalAmount,
    TransactionType? transactionType,
  }) {
    return ExpenseModel(
      index: index ?? this.index,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      transactionType: transactionType ?? this.transactionType,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
