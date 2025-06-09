// lib/screens/kelas/pilih_kelas_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/custom_sidebar.dart'; // ⬇️ Import sidebar

class PilihKelasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kelas'),
        backgroundColor: Color(0xFFD1BB9E),
        elevation: 0,
      ),
      drawer: SideBar(), // ⬇️ Tambahkan sidebar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pilih kelas untuk menambah tugas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Kelas 7'),
                trailing: Icon(Icons.book, size: 48),
                onTap: () {
                  Navigator.pushNamed(context, '/kelas/7');
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Kelas 8'),
                trailing: Icon(Icons.book, size: 48),
                onTap: () {
                  Navigator.pushNamed(context, '/kelas/8');
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Kelas 9'),
                trailing: Icon(Icons.book, size: 48),
                onTap: () {
                  Navigator.pushNamed(context, '/kelas/9');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}