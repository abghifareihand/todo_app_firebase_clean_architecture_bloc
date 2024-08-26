import '../../domain/entities/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.uid,
    required super.name,
    required super.email,
  });

  // Convert from DocumentSnapshot Firestore -> Object
  factory AuthModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return AuthModel(
      uid: snapshot.id,
      name: snapshot['name'],
      email: snapshot['email'],
    );
  }

  // Convert from Map JSON -> Object
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
    );
  }

  // Convert from Object -> Map JSON
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
    };
  }

  @override
  List<Object?> get props => [uid, name, email];
}
