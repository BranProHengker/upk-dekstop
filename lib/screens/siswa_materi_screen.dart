// lib/screens/siswa_materi_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/siswa_sidebar.dart'; // Sidebar khusus siswa
import 'package:sigesit/widgets/gradient_background.dart';
import 'package:sigesit/services/materi_service.dart';

class SiswaMateriScreen extends StatefulWidget {
  @override
  _SiswaMateriScreenState createState() => _SiswaMateriScreenState();
}

class _SiswaMateriScreenState extends State<SiswaMateriScreen> {
  List<Map<String, dynamic>> daftarMateri = [];
  final MateriService _materiService = MateriService();

  @override
  void initState() {
    super.initState();
    _loadMateri(); // Muat materi saat halaman dibuka
  }

  Future<void> _loadMateri() async {
    final materiList = await _materiService.getMateri();
    setState(() {
      daftarMateri = materiList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Materi - Siswa'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SiswaSideBar(), // Sidebar khusus siswa
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Materi Pelajaran',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: daftarMateri.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada materi tersedia.',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: daftarMateri.length,
                        itemBuilder: (context, index) {
                          var item = daftarMateri[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://source.unsplash.com/random/100x100/?education',
                                ),
                              ),
                              title: Text(
                                item['judul'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(item['deskripsi']),
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