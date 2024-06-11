import 'package:flutter/material.dart';
import 'package:prueba2_karenh/models/cita-models.dart';

class CitaProvider with ChangeNotifier {
  final Firestore _firestore = Firestore.instance;
  List<Cita> _appointments = [];

  List<Cita> get appointments => _appointments;

  Future<void> fetchAppointments() async {
    var snapshot = await _firestore.collection('appointments').getDocuments();
    _appointments = snapshot.documents.map((doc) => Cita.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> addAppointment(Cita appointment) async {
    var docRef = await _firestore.collection('appointments').add(appointment.toMap());
    appointment.id = docRef.id;
    _appointments.add(appointment);
    notifyListeners();
  }

  Future<void> updateAppointment(Cita appointment) async {
    await _firestore.collection('appointments').document(appointment.id).updateData(appointment.toMap());
    int index = _appointments.indexWhere((a) => a.id == appointment.id);
    if (index != -1) {
      _appointments[index] = appointment;
      notifyListeners();
    }
  }

  Future<void> deleteAppointment(String id) async {
    await _firestore.collection('appointments').document(id).delete();
    _appointments.removeWhere((a) => a.id == id);
    notifyListeners();
  }
}