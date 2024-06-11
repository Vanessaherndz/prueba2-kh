import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba2_karenh/models/cita-models.dart';

class CitaProvider with ChangeNotifier {
  final CollectionReference _db = FirebaseFirestore.instance.collection('citas');
  List<Cita> _crudpruebakh = [];

  List<Cita> get appointments => _crudpruebakh;

  Future<void> fetchAppointments() async {
    QuerySnapshot snapshot = await _db.get();
    _crudpruebakh = snapshot.docs.map((doc) => Cita.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> addAppointment(Cita appointment) async {
    await _db.add(appointment.toMap());
    fetchAppointments();
  }

  Future<void> updateAppointment(Cita appointment) async {
    await _db.doc(appointment.id).update(appointment.toMap());
    fetchAppointments();
  }

  Future<void> deleteAppointment(String id) async {
    await _db.doc(id).delete();
    fetchAppointments();
  }
}
