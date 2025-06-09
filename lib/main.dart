// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/materi_screen.dart';
import 'screens/tambah_materi_screen.dart';
import 'screens/edit_materi_screen.dart';
import 'screens/siswa_materi_screen.dart';
import 'screens/dashboard_siswa_screen.dart';
import 'screens/kelas/pilih_kelas_screen.dart';
import 'screens/kelas/kelas_7_screen.dart';
import 'screens/kelas/kelas_7a_screen.dart'; 
// import 'screens/nilai_screen.dart';
// import 'screens/detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigesit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/materi': (context) => MateriScreen(),
        '/tambah-materi': (context) => TambahMateriScreen(),
        '/edit-materi': (context) => EditMateriScreen(materi: {}),
        '/siswa/materi': (context) => SiswaMateriScreen(),
        '/dashboard/siswa': (context) => DashboardSiswaScreen(),
        '/kelas': (context) => PilihKelasScreen(),
        '/kelas/7': (context) => Kelas7Screen(),
        '/kelas/7A': (context) => Kelas7AScreen(),
        // '/detail': (context) => DetailScreen(),
        // '/nilai': (context) => NilaiScreen(),
        // Hapus '/materi' jika file materi_screen.dart sudah dihapus
      },
    );
  }
}