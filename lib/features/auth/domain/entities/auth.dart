import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String uid;
  final String name;
  final String email;

  const Auth({
    required this.uid,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [uid, name, email];
}
