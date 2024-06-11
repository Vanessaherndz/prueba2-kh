import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2_karenh/models/cita-models.dart';
import 'package:prueba2_karenh/providers/cita.dart';
import 'package:prueba2_karenh/providers/doctor.dart';
import 'package:prueba2_karenh/providers/paciente.dart';


class AppointmentForm extends StatefulWidget {
  final Cita appointment;

  const AppointmentForm({super.key, required this.appointment});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  late String _doctorId;
  late String _patientId;
  late DateTime _dateTime;
  late String _notes;

  @override
  void initState() {
    super.initState();
    if (widget.appointment != null) {
      _doctorId = widget.appointment.doctorId;
      _patientId = widget.appointment.patientId;
      _dateTime = widget.appointment.dateTime;
      _notes = widget.appointment.notes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<CitaProvider>(context);
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final patientProvider = Provider.of<PacienteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment == null ? 'Agregar Cita' : 'Editar Cita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                value: _doctorId,
                items: doctorProvider.doctors.map((doctor) {
                  return DropdownMenuItem(
                    value: doctor.id,
                    child: Text(doctor.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _doctorId = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Doctor'),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione un doctor';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _patientId,
                items: patientProvider.patients.map((patient) {
                  return DropdownMenuItem(
                    value: patient.id,
                    child: Text(patient.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _patientId = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Paciente'),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione un paciente';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _dateTime != null ? _dateTime.toString() : '',
                decoration: const InputDecoration(labelText: 'Fecha y Hora'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _dateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
                      });
                    }
                  }
                },
                validator: (value) {
                  if (_dateTime == null) {
                    return 'Por favor seleccione una fecha y hora';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _notes,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 3,
                onSaved: (value) {
                  _notes = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Guardar'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    if (widget.appointment == null) {
                      appointmentProvider.addAppointment(Cita(
                        doctorId: _doctorId,
                        patientId: _patientId,
                        dateTime: _dateTime,
                        notes: _notes, id: '',
                      ));
                    } else {
                      appointmentProvider.updateAppointment(Cita(
                        id: widget.appointment.id,
                        doctorId: _doctorId,
                        patientId: _patientId,
                        dateTime: _dateTime,
                        notes: _notes,
                      ));
                    }
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
