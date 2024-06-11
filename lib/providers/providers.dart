import 'package:flutter/material.dart';
import 'package:prueba2_karenh/models/cita-models.dart';
import 'package:prueba2_karenh/models/doctor-models.dart';
import 'package:prueba2_karenh/models/paciente-models.dart';

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
