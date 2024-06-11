import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String id;
  String name;
  String specialty;
  String schedule;
  bool availability;
  String photoUrl;

  Doctor({this.id, this.name, this.specialty, this.schedule, this.availability, this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialty': specialty,
      'schedule': schedule,
      'availability': availability,
      'photoUrl': photoUrl,
    };
  }

  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Doctor(
      id: doc.id,
      name: data['name'],
      specialty: data['specialty'],
      schedule: data['schedule'],
      availability: data['availability'],
      photoUrl: data['photoUrl'],
    );
  }
}



