import 'package:expenses_tracker/core/error/failure.dart';
import 'package:expenses_tracker/modules/main/data/datasources/expense_local_datasource.dart';
import 'package:expenses_tracker/modules/main/data/models/expense_model.dart';
import 'package:expenses_tracker/modules/main/domain/entities/expense.dart';
import 'package:expenses_tracker/modules/main/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/enums/transaction_type.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource expenseLocalDataSource;

  ExpenseRepositoryImpl(this.expenseLocalDataSource);

  @override
  Future<Either<Failure, Expense>> addExpense({
    required int index,
    required double amount,
    required DateTime date,
    required String description,
    required TransactionType transactionType,
  }) async {
    final expense = ExpenseModel(
      index: index,
      amount: () {
        switch (transactionType) {
          case TransactionType.credit:
            return -amount;
          case TransactionType.debit:
            return amount;
        }
      }(),
      date: date,
      description: description,
      transactionType: transactionType,
      totalAmount: 0.0,
    );
    expenseLocalDataSource.addExpense(expense);
    return right(expense);
  }

  @override
  Future<Either<Failure, List<Expense>>> getAllExpenses() async {
    final expenses = expenseLocalDataSource.getAllExpenses();
    return right(expenses);
  }

  @override
  Future<Either<Failure, void>> deleteExpense(int index) async {
    expenseLocalDataSource.deleteExpense(index);
    return right(null);
  }
}
