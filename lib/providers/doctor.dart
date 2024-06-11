
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba2_karenh/models/doctor-models.dart';

class DoctorProvider with ChangeNotifier {
  final CollectionReference _doctorCollection = FirebaseFirestore.instance.collection('doctores');
  List<Doctor> _doctors = [];

  List<Doctor> get doctors => _doctors;

  Future<void> fetchDoctors() async {
    QuerySnapshot snapshot = await _doctorCollection.get();
    _doctors = snapshot.docs.map((doc) => Doctor.fromMap(doc.data(), doc.id)).toList();
    notifyListeners();
  }

  Future<void> addDoctor(Doctor doctor) async {
    await _doctorCollection.add(doctor.toMap());
    fetchDoctors();
  }

  Future<void> updateDoctor(Doctor doctor) async {
    await _doctorCollection.doc(doctor.id).update(doctor.toMap());
    fetchDoctors();
  }

  Future<void> deleteDoctor(String id) async {
    await _doctorCollection.doc(id).delete();
    fetchDoctors();
  }
}