import 'package:cloud_firestore/cloud_firestore.dart';

class Paciente {
  String id;
  String name;
  int age;
  String gender;

  Paciente({this.id, this.name, this.age, this.gender});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
    };
  }

  factory Paciente.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Paciente(
      id: doc.id,
      name: data['name'],
      age: data['age'],
      gender: data['gender'],
    );
  }
}
