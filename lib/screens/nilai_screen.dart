// lib/screens/nilai_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/services/tugas_service.dart';
import 'package:sigesit/widgets/gradient_background.dart';
import 'package:sigesit/widgets/custom_sidebar.dart';
import 'package:sigesit/screens/detail_nilai_siswa_screen.dart';

class NilaiScreen extends StatefulWidget {
  @override
  _NilaiScreenState createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State<NilaiScreen> {
  List<Map<String, dynamic>> daftarTugas = [];
  final TugasService _tugasService = TugasService();

  Future<void> _loadTugas() async {
    try {
      final semuaTugas = await _tugasService.getAllTugasSiswa();

      // Ambil satu entri per siswa (terbaru)
      final Map<String, Map<String, dynamic>> uniqueMap = {};
      for (var task in semuaTugas.reversed) {
        if (!uniqueMap.containsKey(task['siswa'])) {
          uniqueMap[task['siswa']] = task;
        }
      }

      setState(() {
        daftarTugas = uniqueMap.values.toList();
      });
    } catch (e) {
      print('Error loading tasks: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat daftar siswa')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTugas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penilaian Tugas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SideBar(),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar Siswa yang Sudah Mengumpulkan Tugas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),

              Expanded(
                child: daftarTugas.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada tugas dikumpulkan.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: daftarTugas.length,
                        itemBuilder: (context, index) {
                          var item = daftarTugas[index];

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage('https://source.unsplash.com/random/100x100/?student'),
                              ),
                              title: Text(item['siswa']),
                              subtitle: Text(item['status']),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailNilaiSiswaScreen(
                                      namaSiswa: item['siswa'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
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