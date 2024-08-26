import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String uid;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool status;

  const Todo({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.status,
  });

  @override
  List<Object?> get props => [id, uid, title, description, category, date, status];
}
