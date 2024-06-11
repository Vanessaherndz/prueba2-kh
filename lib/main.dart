import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba2_karenh/providers/doctor.dart';
import 'package:prueba2_karenh/screens/pantalla-citas.dart';

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
              Tab(text: 'Formulario'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AppointmentsScreen(),
          ],
        ),
      ),
    );
  }
}

