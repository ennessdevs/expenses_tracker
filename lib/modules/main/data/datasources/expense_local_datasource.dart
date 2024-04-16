import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

import '../models/expense_model.dart';

abstract interface class ExpenseLocalDataSource {
  void addExpense(ExpenseModel expense);

  void updateExpense(ExpenseModel expense);

  void deleteExpense(int index);

  List<ExpenseModel> getAllExpenses();
}

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final Box<Map> box;

  ExpenseLocalDataSourceImpl(this.box);

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    final val = await box.add(expense.toJson());
    final key = await box.keyAt(val);
    print(key);
    box.putAt(val, expense.copyWith(index: key).toJson());
  }

  @override
  void deleteExpense(int index) {
    box.delete(index);
  }

  @override
  List<ExpenseModel> getAllExpenses() {
    List<ExpenseModel> expenses = [];
    double amount = 0.0;
    final items = box.values.sortWithDate((instance) => DateTime.parse(instance['date']));
    for (var i = 0; i < items.length; i++) {
      amount = amount + items.elementAt(i)['amount'];
      expenses.add(
          ExpenseModel.fromJson(items.elementAt(i).cast<String, dynamic>())
              .copyWith(totalAmount: amount));
    }
    expenses.sort(
      (a, b) {
        return a.date.compareTo(b.date);
      },
    );
    return expenses;
  }

  @override
  void updateExpense(ExpenseModel expense) {
    // TODO: implement updateExpense
  }
}
