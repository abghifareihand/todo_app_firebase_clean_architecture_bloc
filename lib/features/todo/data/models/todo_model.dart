import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.uid,
    required super.title,
    required super.description,
    required super.category,
    required super.status,
    required super.date,
  });

  // Convert from DocumentSnapshot Firestore -> Object
  factory TodoModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return TodoModel(
      id: snapshot.id,
      uid: snapshot['uid'],
      title: snapshot['title'],
      description: snapshot['description'],
      category: snapshot['category'],
      status: snapshot['status'],
      date: (snapshot['date'] as Timestamp).toDate(),
    );
  }

  // Convert from Map JSON -> Object
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"],
      uid: json["uid"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      status: json["status"],
      date: json["date"],
    );
  }

  // Convert from Object -> Map JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "title": title,
      "description": description,
      "category": category,
      "status": status,
      "date": date,
    };
  }

  @override
  List<Object?> get props => [id, uid, title, description, category, status, date];
}
