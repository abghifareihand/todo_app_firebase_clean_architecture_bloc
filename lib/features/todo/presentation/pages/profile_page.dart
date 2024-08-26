import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/components/custom_button.dart';
import 'package:todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_app/features/auth/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutLoaded) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return CustomButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
              text: 'Logout',
              isLoading: state is AuthLoading,
            );
          },
        ),
      ),
    );
  }
}
