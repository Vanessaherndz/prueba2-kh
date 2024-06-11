import 'package:cloud_firestore/cloud_firestore.dart';

class Cita {
  String id;
  String doctorId;
  String patientId;
  DateTime dateTime;
  String notes;

  Cita({this.id, this.doctorId, this.patientId, this.dateTime, this.notes});

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'patientId': patientId,
      'dateTime': dateTime.toIso8601String(),
      'notes': notes,
    };
  }

  factory Cita.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Cita(
      id: doc.id,
      doctorId: data['doctorId'],
      patientId: data['patientId'],
      dateTime: DateTime.parse(data['dateTime']),
      notes: data['notes'],
    );
  }
}