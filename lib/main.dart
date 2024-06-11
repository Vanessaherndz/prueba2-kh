import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: MaterialApp(
        title: 'CRUD App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CRUD App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Doctores'),
              Tab(text: 'Pacientes'),
              Tab(text: 'Citas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DoctorsScreen(),
            PatientsScreen(),
            AppointmentsScreen(),
          ],
        ),
      ),
    );
  }
}

