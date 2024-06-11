
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba2_karenh/models/paciente-models.dart';

class PacienteProvider with ChangeNotifier {
  final CollectionReference _patientCollection = FirebaseFirestore.instance.collection('pacientes');
  List<Paciente> _patients = [];

  List<Paciente> get patients => _patients;

  Future<void> fetchPatients() async {
    QuerySnapshot snapshot = await _patientCollection.get();
    _patients = snapshot.docs.map((doc) => Paciente.fromMap(doc.data(), doc.id)).toList();
    notifyListeners();
  }

  Future<void> addPatient(Paciente patient) async {
    await _patientCollection.add(patient.toMap());
    fetchPatients();
  }

  Future<void> updatePatient(Paciente patient) async {
    await _patientCollection.doc(patient.id).update(patient.toMap());
    fetchPatients();
  }

  Future<void> deletePatient(String id) async {
    await _patientCollection.doc(id).delete();
    fetchPatients();
  }
}