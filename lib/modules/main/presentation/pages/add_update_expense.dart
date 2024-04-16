import 'package:expenses_tracker/core/enums/transaction_type.dart';
import 'package:expenses_tracker/modules/main/presentation/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateExpense extends StatefulWidget {
  static route([bool edit = false]) => MaterialPageRoute(
        builder: (context) => AddUpdateExpense(
          edit: edit,
        ),
      );
  final bool edit;

  const AddUpdateExpense({super.key, this.edit = false});

  @override
  State<AddUpdateExpense> createState() => _AddUpdateExpenseState();
}

class _AddUpdateExpenseState extends State<AddUpdateExpense> {
  final formState = GlobalKey<FormState>();
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  TransactionType transactionType = TransactionType.credit;
  DateTime _pickedDate = DateTime.now().copyWith(
    hour: 0,
    minute: 0,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  );

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.edit ? "Edit" : "Add"} Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(hintText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.trim() == '') {
                    return 'Amount required';
                  } else if (double.tryParse(val.trim()) == null) {
                    return 'invalid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  _pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(
                      const Duration(days: 30),
                    ),
                  ).then((value) =>
                      value ??
                      DateTime.now().copyWith(
                        hour: 0,
                        minute: 0,
                        second: 0,
                        millisecond: 0,
                        microsecond: 0,
                      ));
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.teal,
                    width: 3,
                  )),
                  width: double.infinity,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Text(
                      _pickedDate.toIso8601String(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(hintText: 'Short Description'),
                validator: (e) {
                  if (e == '') {
                    return "description is required";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: TransactionType.credit,
                    groupValue: transactionType,
                    onChanged: (value) {
                      if (transactionType != TransactionType.credit) {
                        setState(() {
                          transactionType = TransactionType.credit;
                        });
                      }
                    },
                  ),
                  const Text("Expense"),
                  const SizedBox(width: 20,),
                  Radio(
                    value: TransactionType.debit,
                    groupValue: transactionType,
                    onChanged: (value) {
                      if (transactionType != TransactionType.debit) {
                        setState(() {
                          transactionType = TransactionType.debit;
                        });
                      }
                    },
                  ),
                  const Text("Income"),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      formState.currentState!.validate();
                      context.read<ExpenseBloc>().add(
                            ExpenseAdd(
                              index: -1,
                              amount:
                                  double.parse(amountController.text.trim()),
                              date: _pickedDate,
                              description: descriptionController.text.trim(),
                              transactionType: transactionType,
                            ),
                          );
                      context
                          .read<ExpenseBloc>()
                          .add(ExpenseFetchAllExpenses());
                      Navigator.pop(context);
                    },
                    child: const Text('Add')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
