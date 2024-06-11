import 'package:cloud_firestore/cloud_firestore.dart';

class Cita {
  String id;
  String doctorId;
  String patientId;
  DateTime dateTime;
  String notes;

  Cita({required this.id, required this.doctorId, required this.patientId, required this.dateTime, required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'dateTime': dateTime.toIso8601String(),
      'notes': notes,
    };
  }

  static Cita fromMap(Map<String, dynamic> map, String id) {
    return Cita(
      id: id,
      doctorId: map['doctorId'],
      patientId: map['patientId'],
      dateTime: DateTime.parse(map['dateTime']),
      notes: map['notes'],
    );
  }

  static fromFirestore(QueryDocumentSnapshot<Object?> doc) {}
}
