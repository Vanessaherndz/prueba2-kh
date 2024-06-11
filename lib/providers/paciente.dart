import 'package:flutter/material.dart';
import 'package:prueba2_karenh/models/paciente-models.dart';

class PacienteProvider with ChangeNotifier {
  final Firestore _firestore = Firestore.instance;
  List<Paciente> _patients = [];

  List<Paciente> get patients => _patients;

  Future<void> fetchPatients() async {
    var snapshot = await _firestore.collection('patients').getDocuments();
    _patients = snapshot.documents.map((doc) => Paciente.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> addPatient(Paciente patient) async {
    var docRef = await _firestore.collection('patients').add(patient.toMap());
    patient.id = docRef.id;
    _patients.add(patient);
    notifyListeners();
  }

  Future<void> updatePatient(Paciente patient) async {
    await _firestore.collection('patients').document(patient.id).updateData(patient.toMap());
    int index = _patients.indexWhere((p) => p.id == patient.id);
    if (index != -1) {
      _patients[index] = patient;
      notifyListeners();
    }
  }

  Future<void> deletePatient(String id) async {
    await _firestore.collection('patients').document(id).delete();
    _patients.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}