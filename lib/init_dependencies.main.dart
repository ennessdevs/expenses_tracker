part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  Hive.registerAdapter(TransactionTypeAdapter());
  await Hive.initFlutter();
  final box = serviceLocator.registerSingleton(await Hive.openBox<Map>('expenses'));
  // box.deleteFromDisk();
  _initExpense();
}

void _initExpense() {
  serviceLocator
    ..registerFactory<ExpenseLocalDataSource>(
        () => ExpenseLocalDataSourceImpl(serviceLocator()))
    ..registerFactory<ExpenseRepository>(
        () => ExpenseRepositoryImpl(serviceLocator()))
    ..registerFactory(() => FetchExpenses(serviceLocator()))
    ..registerFactory(() => AddExpense(serviceLocator()))
    ..registerFactory(() => DeleteExpense(serviceLocator()))
    ..registerLazySingleton(() => ExpenseBloc(
          fetchExpenses: serviceLocator(),
          addExpense: serviceLocator(),
          deleteExpense: serviceLocator(),
        ));
}
