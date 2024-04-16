part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}

final class ExpenseFailure extends ExpenseState {
  final String error;

  ExpenseFailure(this.error);
}

final class ExpenseAddSuccess extends ExpenseState {}

final class ExpenseUpdateSuccess extends ExpenseState {}

final class ExpenseDeleteSuccess extends ExpenseState {}

final class ExpenseDisplaySuccess extends ExpenseState {
  final List<Expense> expenses;

  ExpenseDisplaySuccess(this.expenses);
}
