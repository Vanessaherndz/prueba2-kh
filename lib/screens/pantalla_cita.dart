import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2_karenh/providers/cita.dart';
import 'package:prueba2_karenh/screens/formulario-citas.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<CitaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Citas')),
      body: FutureBuilder(
        future: appointmentProvider.fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: appointmentProvider.appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointmentProvider.appointments[index];
                return ListTile(
                  title: Text('${appointment.doctorId} - ${appointment.patientId}'),
                  subtitle: Text('${appointment.dateTime}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AppointmentForm(appointment: appointment),
                          ));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          appointmentProvider.deleteAppointment(appointment.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AppointmentForm(),
          ));
        },
      ),
    );
  }
}
