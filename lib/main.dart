import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/injection.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/todo/data/datasources/notification_service.dart';
import 'features/todo/presentation/bloc/add_todo/add_todo_bloc.dart';
import 'features/todo/presentation/bloc/delete_todo/delete_todo_bloc.dart';
import 'features/todo/presentation/bloc/get_completed_todo/get_completed_todo_bloc.dart';
import 'features/todo/presentation/bloc/get_date_todo/get_date_todo_bloc.dart';
import 'features/todo/presentation/bloc/get_pending_todo/get_pending_todo_bloc.dart';
import 'features/todo/presentation/bloc/update_todo/update_todo_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  await NotificationService.initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AddTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DeleteTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<UpdateTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetPendingTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetCompletedTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetDateTodoBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const SplashPage(),
      ),
    );
  }
}

// DOMAIN LAYER
// 1. ENTITIES
// 2. REPOSITORIES (ABSTRACT)
// 3. USE CASE

// DATA LAYER
// 1. MODEL (EXTEND ENTITIES)
// 2. DATASOURCES (MODEL)
// 3. REPOSITORIES IMPL (MODEL ENTITIES)

// PRESENTATION LAYER
// 1. BLOC (USECASES)
// 2. SLICING UI