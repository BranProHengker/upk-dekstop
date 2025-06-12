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
  bool _sudahSubmit = false;

  void _kumpulkanTugas(BuildContext context) async {
    String jawaban = _jawabanController.text;

    if (jawaban.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jawaban tidak boleh kosong')),
      );
      return;
    }

    await _tugasService.simpanTugas(
      widget.materi['judul'],
      widget.username ?? 'Anonymous',
      jawaban,
    );

    setState(() {
      _sudahSubmit = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tugas berhasil dikumpulkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kerjakan Tugas'),
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
                enabled: !_sudahSubmit,
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

              // Tombol Kumpulkan
              ElevatedButton.icon(
                onPressed: _sudahSubmit ? null : () => _kumpulkanTugas(context),
                icon: Icon(Icons.send),
                label: Text(_sudahSubmit ? 'Sudah Dikumpulkan' : 'Kumpulkan Tugas'),
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