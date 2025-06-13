// lib/screens/siswa_tugas_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/services/tugas_service.dart';
import 'package:sigesit/widgets/siswa_sidebar.dart';
import 'package:sigesit/widgets/gradient_background.dart';

class SiswaTugasScreen extends StatefulWidget {
  final Map<String, dynamic> materi;
  final String? username;

  const SiswaTugasScreen({
    Key? key,
    required this.materi,
    required this.username,
  }) : super(key: key);

  @override
  _SiswaTugasScreenState createState() => _SiswaTugasScreenState();
}

class _SiswaTugasScreenState extends State<SiswaTugasScreen> {
  final TextEditingController _jawabanController = TextEditingController();
  final TugasService _tugasService = TugasService();

  @override
  void dispose() {
    _jawabanController.dispose(); // Selalu panggil dispose pada controller
    super.dispose();
  }

  Future<void> _kumpulkanTugas(BuildContext context) async {
    String jawaban = _jawabanController.text.trim();

    if (jawaban.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jawaban tidak boleh kosong')),
      );
      return;
    }

    // Debug log
    print("Menyimpan tugas untuk materi ID: ${widget.materi['judul']}");

    try {
      await _tugasService.simpanTugas(
        widget.materi['judul'],
        widget.username ?? 'Anonymous',
        jawaban,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tugas berhasil dikumpulkan')),
      );

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengumpulkan tugas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kerjakan Tugas'),
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
                widget.materi['judul'] ?? 'Tugas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                widget.materi['deskripsi'] ?? 'Deskripsi tidak tersedia.',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),

              // Input Jawaban
              TextField(
                controller: _jawabanController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Jawaban',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF948C7A), width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),

              SizedBox(height: 20),

              // Tombol Kumpulkan Tugas
              ElevatedButton.icon(
                onPressed: () => _kumpulkanTugas(context), // ✅ Fix: Gunakan lambda agar bisa kirim context
                icon: Icon(Icons.send),
                label: Text('Kumpulkan Tugas'),
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