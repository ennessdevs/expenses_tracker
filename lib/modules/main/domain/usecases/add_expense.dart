import 'package:expenses_tracker/core/error/failure.dart';
import 'package:expenses_tracker/core/usecase/usecase.dart';
import 'package:expenses_tracker/modules/main/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/enums/transaction_type.dart';

class AddExpense implements UseCase<void, AddExpenseParms> {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(AddExpenseParms params) async {
    return await repository.addExpense(
      index: params.index,
      amount: params.amount,
      date: params.date,
      description: params.description,
      transactionType: params.transactionType,
    );
  }
}

class AddExpenseParms {
  final int index;
  final double amount;
  final DateTime date;
  final String description;
  final TransactionType transactionType;

  AddExpenseParms({
    required this.index,
    required this.amount,
    required this.date,
    required this.description,
    required this.transactionType,
  });
}
