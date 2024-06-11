import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba2_karenh/models/cita-models.dart';

class CitaProvider with ChangeNotifier {
  final CollectionReference _appointmentCollection = FirebaseFirestore.instance.collection('citas');
  List<Cita> _appointments = [];

  List<Cita> get appointments => _appointments;

  Future<void> fetchAppointments() async {
    QuerySnapshot snapshot = await _appointmentCollection.get();
    _appointments = snapshot.docs.map((doc) => Cita.fromMap(doc.data(), doc.id)).toList();
    notifyListeners();
  }

  Future<void> addAppointment(Cita appointment) async {
    await _appointmentCollection.add(appointment.toMap());
    fetchAppointments();
  }

  Future<void> updateAppointment(Cita appointment) async {
    await _appointmentCollection.doc(appointment.id).update(appointment.toMap());
    fetchAppointments();
  }

  Future<void> deleteAppointment(String id) async {
    await _appointmentCollection.doc(id).delete();
    fetchAppointments();
  }
}
