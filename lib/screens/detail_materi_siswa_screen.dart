import 'package:flutter/material.dart';
import 'package:sigesit/widgets/siswa_sidebar.dart'; 
import 'package:sigesit/widgets/gradient_background.dart';

class DetailMateriSiswaScreen extends StatelessWidget {
  final Map<String, dynamic> materi;
  final String? username;

  const DetailMateriSiswaScreen({
    Key? key,
    required this.materi,
    this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Materi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SiswaSideBar(),
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

              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/siswa-tugas',
                    arguments: {
                      'materi': materi,
                      'username': username,
                    },
                  );
                },
                icon: Icon(Icons.assignment_turned_in),
                label: Text('Kerjakan Tugas'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF948C7A),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}