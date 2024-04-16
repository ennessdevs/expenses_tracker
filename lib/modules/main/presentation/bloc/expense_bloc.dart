import 'dart:async';

import 'package:expenses_tracker/core/enums/transaction_type.dart';
import 'package:expenses_tracker/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/expense.dart';
import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/delete_expense.dart';
import '../../domain/usecases/fetch_expenses.dart';

part 'expense_event.dart';

part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final FetchExpenses _fetchExpenses;
  final AddExpense _addExpense;
  final DeleteExpense _deleteExpense;

  ExpenseBloc(
      {required FetchExpenses fetchExpenses,
      required AddExpense addExpense,
      required DeleteExpense deleteExpense})
      : _fetchExpenses = fetchExpenses,
        _addExpense = addExpense,
        _deleteExpense = deleteExpense,
        super(ExpenseInitial()) {
    on<ExpenseFetchAllExpenses>(_onFetchAllExpenses);
    on<ExpenseAdd>(_onAddExpense);
    on<ExpenseDelete>(_onExpenseDelete);
  }

  _onFetchAllExpenses(
    ExpenseFetchAllExpenses event,
    Emitter<ExpenseState> emit,
  ) async {
    final res = await _fetchExpenses(NoParams());
    res.fold(
      (l) => emit(ExpenseFailure(l.message)),
      (r) => emit(ExpenseDisplaySuccess(r)),
    );
  }

  _onAddExpense(
    ExpenseAdd event,
    Emitter<ExpenseState> emit,
  ) async {
    final res = await _addExpense(
      AddExpenseParms(
        index: event.index,
        amount: event.amount,
        date: event.date,
        description: event.description,
        transactionType: event.transactionType,
      ),
    );
    res.fold(
      (l) => emit(ExpenseFailure(l.message)),
      (r) => emit(ExpenseAddSuccess()),
    );
  }

  _onExpenseDelete(ExpenseDelete event, Emitter<ExpenseState> emit) {
    _deleteExpense(event.index);
  }
}
