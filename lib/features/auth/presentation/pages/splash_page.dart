import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/features/todo/presentation/pages/main_page.dart';

import '../../../todo/presentation/pages/home_page.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/models/auth_model.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthLocalDatasource authLocalDatasource = GetIt.I<AuthLocalDatasource>();

  @override
  void initState() {
    _checkAuthentication();
    super.initState();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2));
    final AuthModel? authData = await authLocalDatasource.getAuthData();

    if (mounted) {
      if (authData != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 100,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'TODO APP',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
