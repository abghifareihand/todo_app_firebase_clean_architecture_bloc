import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/todo/data/datasources/todo_remote_datasource.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/add_todo_usecase.dart';
import 'features/todo/domain/usecases/delete_todo_usecase.dart';
import 'features/todo/domain/usecases/get_completed_todo_usecase.dart';
import 'features/todo/domain/usecases/get_date_todo_usecase.dart';
import 'features/todo/domain/usecases/get_pending_todo_usecase.dart';
import 'features/todo/domain/usecases/update_todo_status_usecase.dart';
import 'features/todo/domain/usecases/update_todo_usecase.dart';
import 'features/todo/presentation/bloc/add_todo/add_todo_bloc.dart';
import 'features/todo/presentation/bloc/delete_todo/delete_todo_bloc.dart';
import 'features/todo/presentation/bloc/get_completed_todo/get_completed_todo_bloc.dart';
import 'features/todo/presentation/bloc/get_date_todo/get_date_todo_bloc.dart';
import 'features/todo/presentation/bloc/get_pending_todo/get_pending_todo_bloc.dart';
import 'features/todo/presentation/bloc/update_todo/update_todo_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // FIREBASE
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  // SHARED PREFERENCES
  final pref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => pref);

  /// [FEATURE - AUTH]
  // BLOC
  getIt.registerFactory(
    () => AuthBloc(
      loginUsecase: getIt(),
      registerUsecase: getIt(),
      logoutUsecase: getIt(),
    ),
  );

  // USECASES
  getIt.registerLazySingleton(() => LoginUsecase(getIt()));
  getIt.registerLazySingleton(() => RegisterUsecase(getIt()));
  getIt.registerLazySingleton(() => LogoutUsecase(getIt()));

  // REPOSITORY
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: getIt(),
      authLocalDatasource: getIt(),
    ),
  );

  // DATASOURCE
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      firebaseFirestore: getIt(),
      firebaseAuth: getIt(),
    ),
  );
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(
      sharedPreferences: getIt(),
    ),
  );

  /// [FEATURE - TODOS]
  // BLOC
  getIt.registerFactory(
    () => AddTodoBloc(
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => DeleteTodoBloc(
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => GetPendingTodoBloc(
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => GetCompletedTodoBloc(
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => GetDateTodoBloc(
      getIt(),
    ),
  );
  getIt.registerFactory(
    () => UpdateTodoBloc(
      getIt(),
      getIt(),
    ),
  );

  // USECASES
  getIt.registerLazySingleton(() => AddTodoUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteTodoUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateTodoUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateTodoStatusUsecase(getIt()));
  getIt.registerLazySingleton(() => GetPendingTodoUsecase(getIt()));
  getIt.registerLazySingleton(() => GetCompletedTodoUsecase(getIt()));
  getIt.registerLazySingleton(() => GetDateTodoUsecase(getIt()));

  // REPOSITORY
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      todoRemoteDatasource: getIt(),
    ),
  );

  // DATASOURCE
  getIt.registerLazySingleton<TodoRemoteDatasource>(
    () => TodoRemoteDatasourceImpl(
      firebaseFirestore: getIt(),
      firebaseAuth: getIt(),
    ),
  );
}
