import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/todo_model.dart';

abstract class TodoRemoteDatasource {
  Future<TodoModel> addTodo(String title, String description, String category, DateTime date);
  Future<String> updateTodo(String id, String title, String description, String category);
  Future<String> deleteTodo(String id);
  Future<String> updateTodoStatus(String id, bool status);
  Stream<List<TodoModel>> getCompletedTodo();
  Stream<List<TodoModel>> getPendingTodo();
  Stream<List<TodoModel>> getDateTodo(DateTime date);
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  TodoRemoteDatasourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  @override
  Future<TodoModel> addTodo(String title, String description, String category, DateTime date) async {
    try {
      final user = firebaseAuth.currentUser!;
      final docRef = await firebaseFirestore.collection('todos').add({
        'uid': user.uid, // Menyimpan UID pengguna
        'title': title,
        'description': description,
        'category': category,
        'date': date,
        'status': false,
      });
      final response = await docRef.get();
      return TodoModel.fromDocumentSnapshot(response);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Stream<List<TodoModel>> getCompletedTodo() {
    try {
      final user = firebaseAuth.currentUser!;
      return firebaseFirestore.collection('todos').where('uid', isEqualTo: user.uid).where('status', isEqualTo: true).orderBy('date').snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => TodoModel.fromDocumentSnapshot(doc)).toList(),
          );
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Stream<List<TodoModel>> getPendingTodo() {
    try {
      final user = firebaseAuth.currentUser!;
      return firebaseFirestore.collection('todos').where('uid', isEqualTo: user.uid).where('status', isEqualTo: false).orderBy('date').snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => TodoModel.fromDocumentSnapshot(doc)).toList(),
          );
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Stream<List<TodoModel>> getDateTodo(DateTime date) {
    try {
      final user = firebaseAuth.currentUser!;
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
      return firebaseFirestore.collection('todos').where('uid', isEqualTo: user.uid).where('date', isGreaterThanOrEqualTo: startOfDay).where('date', isLessThanOrEqualTo: endOfDay).snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => TodoModel.fromDocumentSnapshot(doc)).toList(),
          );
    } catch (e) {
      throw Exception('Failed to get todos by date');
    }
  }

  @override
  Future<String> updateTodo(String id, String title, String description, String category) async {
    try {
      await firebaseFirestore.collection('todos').doc(id).update({
        'title': title,
        'description': description,
        'category': category,
      });
      return 'Update Todo';
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<String> deleteTodo(String id) async {
    try {
      await firebaseFirestore.collection('todos').doc(id).delete();
      return 'Delete Todo';
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<String> updateTodoStatus(String id, bool status) async {
    try {
      await firebaseFirestore.collection('todos').doc(id).update({
        'status': status,
      });
      return 'Update Status Todo';
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
