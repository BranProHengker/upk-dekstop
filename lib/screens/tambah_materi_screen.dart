// lib/screens/tambah_materi_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/services/materi_service.dart';

class TambahMateriScreen extends StatefulWidget {
  @override
  _TambahMateriScreenState createState() => _TambahMateriScreenState();
}

class _TambahMateriScreenState extends State<TambahMateriScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final MateriService _materiService = MateriService();

  void _simpanMateri(BuildContext context) async {
    String judul = _judulController.text;
    String deskripsi = _deskripsiController.text;

    if (judul.isEmpty || deskripsi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    final newMateri = {
      'judul': judul,
      'deskripsi': deskripsi,
    };

    // Simpan ke SharedPreferences
    final updatedList = [...await _materiService.getMateri(), newMateri];
    await _materiService.saveMateri(updatedList);

    // Kembali ke halaman materi dengan data baru
    Navigator.pop(context, newMateri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Materi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: InputDecoration(labelText: 'Judul Materi', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _simpanMateri(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF948C7A),
              ),
              icon: Icon(Icons.save),
              label: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}