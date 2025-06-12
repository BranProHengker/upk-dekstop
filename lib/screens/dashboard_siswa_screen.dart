// lib/screens/dashboard_siswa_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/siswa_sidebar.dart'; // Sidebar khusus siswa
import 'package:sigesit/widgets/gradient_background.dart';

class DashboardSiswaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Siswa'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SiswaSideBar(), // Sidebar khusus siswa
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang, Andi Pratama',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'Kelas 7A - Selamat belajar dan kerjakan tugas tepat waktu!',
                style: TextStyle(color: Colors.white),
              ),

              SizedBox(height: 30),

              // Menu Akses Cepat: Materi Pelajaran
              Card(
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.menu_book, color: Color(0xFF948C7A)),
                  title: Text('Materi Pelajaran'),
                  subtitle: Text('Lihat dan kerjakan tugas dari guru'),
                  onTap: () {
                    Navigator.pushNamed(context, '/siswa/materi');
                  },
                ),
              ),

              SizedBox(height: 16),

              // ⬇️ MENU NILAI DIHAPUS, SISWA TIDAK BISA MELIHAT NILAI

              // Menu Profil
              Card(
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.school, color: Color(0xFF948C7A)),
                  title: Text('Profil'),
                  subtitle: Text('Lihat informasi akun'),
                  onTap: () {
                    // Nanti bisa tambahkan halaman profil siswa
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}