import 'package:expenses_tracker/modules/main/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expense.amount.toString(),
                  style: TextStyle(
                    color:
                        expense.amount.isNegative ? Colors.red : Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Total: ${expense.totalAmount.abs()}",
                  style: TextStyle(
                    color: expense.totalAmount.isNegative
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
