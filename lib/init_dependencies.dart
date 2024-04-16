import 'package:expenses_tracker/core/enums/transaction_type.dart';
import 'package:expenses_tracker/modules/main/data/datasources/expense_local_datasource.dart';
import 'package:expenses_tracker/modules/main/data/models/expense_model.dart';
import 'package:expenses_tracker/modules/main/data/repositories/expense_repository_impl.dart';
import 'package:expenses_tracker/modules/main/domain/repositories/expense_repository.dart';
import 'package:expenses_tracker/modules/main/domain/usecases/add_expense.dart';
import 'package:expenses_tracker/modules/main/domain/usecases/fetch_expenses.dart';
import 'package:expenses_tracker/modules/main/presentation/bloc/expense_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'modules/main/domain/usecases/delete_expense.dart';

part 'init_dependencies.main.dart';

