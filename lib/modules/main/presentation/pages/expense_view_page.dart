import 'package:expenses_tracker/core/utils/show_snackbar.dart';
import 'package:expenses_tracker/modules/main/presentation/bloc/expense_bloc.dart';
import 'package:expenses_tracker/modules/main/presentation/widgets/expense_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'add_update_expense.dart';

class ExpenseViewPage extends StatefulWidget {
  const ExpenseViewPage({super.key});

  @override
  State<ExpenseViewPage> createState() => _ExpenseViewPageState();
}

class _ExpenseViewPageState extends State<ExpenseViewPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(ExpenseFetchAllExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, AddUpdateExpense.route()),
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (BuildContext context, ExpenseState state) {
          if (state is ExpenseFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (BuildContext context, ExpenseState state) {
          if (state is ExpenseDisplaySuccess) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.expenses.length,
                itemBuilder: (context, index) {
                  final expense = state.expenses[index];
                  return Column(
                    children: [
                      if (index == 0 ||
                          state.expenses[index - 1].date
                                  .difference(expense.date)
                                  .inDays <
                              0)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0x90000000),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              expense.date.toIso8601String(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              label: 'Delete',
                              icon: Icons.delete_forever,
                              onPressed: (_) {
                                context
                                    .read<ExpenseBloc>()
                                    .add(ExpenseDelete(index: expense.index));
                                context
                                    .read<ExpenseBloc>()
                                    .add(ExpenseFetchAllExpenses());
                              },
                            ),
                          ],
                        ),
                        child: ExpenseCard(expense: expense),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return const Center(child: Text("Error"));
        },
      ),
    );
  }
}
