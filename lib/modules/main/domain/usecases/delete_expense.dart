import 'package:expenses_tracker/core/error/failure.dart';
import 'package:expenses_tracker/core/usecase/usecase.dart';
import 'package:expenses_tracker/modules/main/data/models/expense_model.dart';
import 'package:expenses_tracker/modules/main/domain/repositories/expense_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteExpense implements UseCase<void, int> {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  @override
  Future<Either<Failure, void>> call(int index) async {
    return await repository.deleteExpense(index);
  }
}
