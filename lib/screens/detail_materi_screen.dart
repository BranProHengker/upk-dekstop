// lib/screens/detail_materi_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/gradient_background.dart';

class DetailMateriScreen extends StatelessWidget {
  final Map<String, dynamic> materi;
  final String? username; // ⬅️ Username dari login

  DetailMateriScreen({required this.materi, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Materi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                materi['judul'] ?? 'Materi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                materi['deskripsi'] ?? 'Deskripsi tidak tersedia.',
                style: TextStyle(color: Colors.white),
              ),

              // Tombol Kerjakan Tugas hanya muncul untuk role siswa
              if (username != null && username == 'siswa') ...[
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/kelas/7A', arguments: materi);
                  },
                  icon: Icon(Icons.assignment_turned_in),
                  label: Text('Kerjakan Tugas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF948C7A),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}