import 'package:flutter/material.dart';
import 'package:sigesit/services/tugas_service.dart';
import 'package:sigesit/widgets/siswa_sidebar.dart'; 
import 'package:sigesit/widgets/gradient_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailMateriSiswaScreen extends StatefulWidget {
  final Map<String, dynamic> materi;
  final String? username;

  const DetailMateriSiswaScreen({
    Key? key,
    required this.materi,
    this.username,
  }) : super(key: key);

  @override
  _DetailMateriSiswaScreenState createState() => _DetailMateriSiswaScreenState();
}

class _DetailMateriSiswaScreenState extends State<DetailMateriSiswaScreen> {
  late Future<Map<String, dynamic>?> _tugasFuture;
  final TugasService _tugasService = TugasService();

  @override
  void initState() {
    super.initState();
    _tugasFuture = _tugasService.getTugasSiswa(
      widget.materi['id'].toString(), 
      widget.username ?? ''
    );
  }

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
                widget.materi['judul'] ?? 'Materi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                widget.materi['deskripsi'] ?? 'Deskripsi tidak tersedia.',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 24),
              
              // Bagian untuk menampilkan jawaban jika sudah ada
              FutureBuilder<Map<String, dynamic>?>(
                future: _tugasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  
                  if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                    final tugas = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jawaban Anda:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tugas['jawaban'] ?? 'Tidak ada jawaban',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 16),
                        if (tugas['status'] == 'Dinilai')
                          Text(
                            'Nilai: ${tugas['nilai']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        SizedBox(height: 16),
                      ],
                    );
                  }
                  
                  return SizedBox.shrink();
                },
              ),
              
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/siswa-tugas',
                    arguments: {
                      'materi': widget.materi,
                      'username': widget.username,
                    },
                  ).then((_) {
                    // Refresh data ketika kembali dari halaman tugas
                    setState(() {
                      _tugasFuture = _tugasService.getTugasSiswa(
                        widget.materi['id'].toString(), 
                        widget.username ?? ''
                      );
                    });
                  });
                },
                icon: Icon(Icons.assignment_turned_in),
                label: Text(widget.materi['status'] == 'Dinilai' ? 'Lihat Tugas' : 'Kerjakan Tugas'),
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