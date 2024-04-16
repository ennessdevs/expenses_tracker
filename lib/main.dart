import 'package:expenses_tracker/core/theme/theme.dart';
import 'package:expenses_tracker/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/main/presentation/bloc/expense_bloc.dart';
import 'modules/main/presentation/pages/expense_view_page.dart';

void main() async{
  await initDependencies();
  runApp(
    BlocProvider(
      create: (context) => serviceLocator<ExpenseBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Tracker',
      theme: AppTheme.theme,
      home: const ExpenseViewPage(),
    );
  }
}
