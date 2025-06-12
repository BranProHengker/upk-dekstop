// lib/screens/kelas/kelas_7a_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/services/tugas_service.dart';

class Kelas7AScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas Siswa - Kelas 7A'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadTugas(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final tugasList = snapshot.data!;
            final siswaYangSudahMengumpulkan = tugasList
                .where((tugas) => tugas['status'] == 'Dinilai' || tugas['status'] == 'Belum Dinilai')
                .toList();

            return ListView.builder(
              itemCount: 5, // Jumlah siswa dalam kelas 7A
              itemBuilder: (context, index) {
                final namaSiswa = ['Andi', 'Budi', 'Citra', 'Dewi', 'Eko'][index];

                final sudahKumpul = siswaYangSudahMengumpulkan.any(
                      (tugas) => tugas['siswa'] == namaSiswa,
                );

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://source.unsplash.com/random/100x100/?student'),
                    ),
                    title: Text(namaSiswa),
                    subtitle: Text(sudahKumpul ? 'Sudah Mengumpulkan' : 'Belum Mengumpulkan'),
                    trailing: Icon(
                      sudahKumpul ? Icons.check_circle : Icons.pending,
                      color: sudahKumpul ? Colors.green : Colors.orange,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadTugas() async {
    final service = TugasService();
    return await service.getTugasByMateri('Matematika - Bab 1'); // Ganti dengan ID/judul materi dinamis
  }
}