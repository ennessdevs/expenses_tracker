import 'package:expenses_tracker/core/enums/transaction_type.dart';
import 'package:expenses_tracker/core/error/failure.dart';
import 'package:expenses_tracker/modules/main/data/models/expense_model.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/expense.dart';

abstract interface class ExpenseRepository {
  Future<Either<Failure, Expense>> addExpense({
    required int index,
    required double amount,
    required DateTime date,
    required String description,
    required TransactionType transactionType,
});
  Future<Either<Failure,List<Expense>>> getAllExpenses();

  Future<Either<Failure,void>> deleteExpense(int index);
}