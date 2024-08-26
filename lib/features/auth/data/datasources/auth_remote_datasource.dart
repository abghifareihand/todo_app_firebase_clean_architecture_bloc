import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/error/failure.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> register(String name, String email, String password);
  Future<AuthModel> login(String email, String password);
  Future<String> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasourceImpl({required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<AuthModel> register(String name, String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;
      final authModel = AuthModel(
        uid: uid,
        name: name,
        email: email,
      );
      await firebaseFirestore.collection('users').doc(uid).set(authModel.toJson());
      return authModel;
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      final response = await firebaseFirestore.collection('users').doc(uid).get();
      if (!response.exists) {
        throw const DatabaseFailure('User Not Found');
      }
      return AuthModel.fromDocumentSnapshot(response);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<String> logout() async {
    try {
      await firebaseAuth.signOut();
      return 'Logged out successfully';
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
