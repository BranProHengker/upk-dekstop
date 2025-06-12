import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/materi_screen.dart';
import 'screens/tambah_materi_screen.dart';
import 'screens/edit_materi_screen.dart';
import 'screens/siswa_materi_screen.dart';
import 'screens/dashboard_siswa_screen.dart';
import 'screens/detail_materi_siswa_screen.dart';
import 'screens/siswa_tugas_screen.dart';
import 'screens/kelas/pilih_kelas_screen.dart';
import 'screens/kelas/kelas_7_screen.dart';
import 'screens/kelas/kelas_7a_screen.dart';
import 'screens/nilai_screen.dart';

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
        '/tambah-materi': (context) => TambahMateriScreen(),
        '/materi': (context) => MateriScreen(),
        '/edit-materi': (context) => EditMateriScreen(materi: {}),
        '/dashboard/siswa': (context) => DashboardSiswaScreen(),
        '/kelas': (context) => PilihKelasScreen(),
        '/kelas/7': (context) => Kelas7Screen(),
        '/kelas/7A': (context) => Kelas7AScreen(),
        '/nilai': (context) => NilaiScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/siswa/materi') {
          // Navigasi ke halaman materi untuk siswa
          return MaterialPageRoute(
            builder: (context) => SiswaMateriScreen(username: 'andi'), // Ganti dengan username login
          );
        } else if (settings.name == '/detail-materi-siswa') {
          // Navigasi ke detail materi siswa
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => DetailMateriSiswaScreen(
              materi: args['materi'],
              username: args['username'] ?? '',
            ),
          );
        } else if (settings.name == '/siswa-tugas') {
          // Navigasi ke halaman tugas siswa
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => SiswaTugasScreen(
              materi: args['materi'],
              username: args['username'] ?? '',
            ),
          );
        }
        return null;
      },
    );
  }
}