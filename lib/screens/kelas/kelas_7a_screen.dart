// lib/screens/kelas/kelas_7a_screen.dart
import 'package:sigesit/widgets/custom_sidebar.dart';
import 'package:flutter/material.dart';

class Kelas7AScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelas 7A'),
        backgroundColor: Color(0xFFD1BB9E),
        elevation: 0,
      ),
      drawer: SideBar(), // ⬇️ Sidebar tetap ada
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Daftar Siswa Kelas 7A',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _siswaKelas7A.length,
                itemBuilder: (context, index) {
                  final siswa = _siswaKelas7A[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(siswa['avatar']),
                      ),
                      title: Text(siswa['nama']),
                      subtitle: Text(siswa['status_tugas']),
                      trailing: Icon(
                        siswa['status_tugas'] == 'Sudah Mengumpulkan'
                            ? Icons.check_circle
                            : Icons.error_outline,
                        color: siswa['status_tugas'] == 'Sudah Mengumpulkan'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data Dummy Siswa Kelas 7A
final List<Map<String, dynamic>> _siswaKelas7A = [
  {
    'nama': 'Andi Pratama',
    'avatar': 'https://source.unsplash.com/random/100x100/?student',
    'status_tugas': 'Sudah Mengumpulkan',
  },
  {
    'nama': 'Budi Setiawan',
    'avatar': 'https://source.unsplash.com/random/100x100/?student',
    'status_tugas': 'Belum Mengumpulkan',
  },
  {
    'nama': 'Citra Dewi',
    'avatar': 'https://source.unsplash.com/random/100x100/?student',
    'status_tugas': 'Sudah Mengumpulkan',
  },
  {
    'nama': 'Dewi Novita',
    'avatar': 'https://source.unsplash.com/random/100x100/?student',
    'status_tugas': 'Belum Mengumpulkan',
  },
];