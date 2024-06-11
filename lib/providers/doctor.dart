import 'package:flutter/material.dart';
import 'package:prueba2_karenh/models/doctor-models.dart';

class DoctorProvider with ChangeNotifier {
  final Firestore _firestore = Firestore.instance;
  List<Doctor> _doctors = [];

  List<Doctor> get doctors => _doctors;

  Future<void> fetchDoctors() async {
    var snapshot = await _firestore.collection('doctors').getDocuments();
    _doctors = snapshot.documents.map((doc) => Doctor.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> addDoctor(Doctor doctor) async {
    var docRef = await _firestore.collection('doctors').add(doctor.toMap());
    doctor.id = docRef.id;
    _doctors.add(doctor);
    notifyListeners();
  }

  Future<void> updateDoctor(Doctor doctor) async {
    await _firestore.collection('doctors').document(doctor.id).updateData(doctor.toMap());
    int index = _doctors.indexWhere((d) => d.id == doctor.id);
    if (index != -1) {
      _doctors[index] = doctor;
      notifyListeners();
    }
  }

  Future<void> deleteDoctor(String id) async {
    await _firestore.collection('doctors').document(id).delete();
    _doctors.removeWhere((d) => d.id == id);
    notifyListeners();
  }
}