import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/components/custom_snackbar.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_field.dart';
import '../../../todo/presentation/pages/home_page.dart';
import '../bloc/auth_bloc.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('BUILD');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomField.email(
              controller: _emailController,
              label: 'Email',
            ),
            CustomField.password(
              controller: _passwordController,
              label: 'Password',
            ),
            const SizedBox(
              height: 20.0,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoginLoaded) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                  showSuccessSnackbar(context, 'Login Success');
                }

                if (state is AuthError) {
                  showErrorSnackbar(context, state.message);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLoginEvent(
                          _emailController.text,
                          _passwordController.text,
                        ));
                  },
                  text: 'Login',
                  isLoading: state is AuthLoading,
                );
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont have an account? ',
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
