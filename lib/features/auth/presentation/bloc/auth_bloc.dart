import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthLogoutEvent>(_onAuthLogout);
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUsecase.execute(
      event.email,
      event.password,
    );
    result.fold(
      (error) => emit(AuthError(error.message)),
      (data) => emit(AuthLoginLoaded(data)),
    );
  }

  void _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUsecase.execute(
      event.name,
      event.email,
      event.password,
    );
    result.fold(
      (error) => emit(AuthError(error.message)),
      (data) => emit(AuthRegisterLoaded(data)),
    );
  }

  void _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUsecase.execute();
    result.fold(
      (error) => emit(AuthError(error.message)),
      (data) => emit(AuthLogoutLoaded(data)),
    );
  }
}
