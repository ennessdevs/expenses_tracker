import 'package:expenses_tracker/core/error/failure.dart';
import 'package:expenses_tracker/core/usecase/usecase.dart';
import 'package:expenses_tracker/modules/main/domain/entities/expense.dart';
import 'package:expenses_tracker/modules/main/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchExpenses implements UseCase<List<Expense>, NoParams> {
  final ExpenseRepository repository;

  FetchExpenses(this.repository);

  @override
  Future<Either<Failure, List<Expense>>> call(NoParams params) async {
    return await repository.getAllExpenses();
  }
}
