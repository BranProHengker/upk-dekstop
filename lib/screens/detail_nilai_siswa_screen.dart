// lib/screens/detail_nilai_siswa_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/services/tugas_service.dart';

class DetailNilaiSiswaScreen extends StatefulWidget {
  final String namaSiswa;

  const DetailNilaiSiswaScreen({Key? key, required this.namaSiswa}) : super(key: key);

  @override
  _DetailNilaiSiswaScreenState createState() => _DetailNilaiSiswaScreenState();
}

class _DetailNilaiSiswaScreenState extends State<DetailNilaiSiswaScreen> {
  late List<Map<String, dynamic>> tugasSiswaList;
  final TugasService _tugasService = TugasService();

  @override
  void initState() {
    super.initState();
    _muatTugasSiswa();
  }

  Future<void> _muatTugasSiswa() async {
    final semuaTugas = await _tugasService.getAllTugasSiswa();
    setState(() {
      tugasSiswaList = semuaTugas
          .where((tugas) => tugas['siswa'] == widget.namaSiswa)
          .toList();
    });
  }

  // Method untuk memberi nilai (sudah ada)
  void _beriNilai(BuildContext context, String idMateri) {
    TextEditingController _nilaiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Beri Nilai untuk ${widget.namaSiswa}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nilaiController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Masukkan Nilai'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final nilai = int.tryParse(_nilaiController.text) ?? 0;
                  if (nilai > 0) {
                    await _tugasService.beriNilai(idMateri, widget.namaSiswa, nilai);
                    Navigator.pop(context);
                    _muatTugasSiswa(); // Refresh UI
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Masukkan nilai valid')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF948C7A),
                ),
                child: Text('Simpan Nilai'),
              )
            ],
          ),
        );
      },
    );
  }

  // Method untuk menghapus tugas
  void _hapusTugas(BuildContext context, String idMateri, String namaSiswa) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus tugas ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Implementasikan logika hapus tugas di sini
                await _tugasService.hapusTugas(idMateri, namaSiswa);
                Navigator.pop(context); // Tutup dialog
                _muatTugasSiswa(); // Refresh UI
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tugas - ${widget.namaSiswa}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tugasSiswaList.isEmpty
            ? Center(child: Text('Belum ada tugas'))
            : ListView.builder(
                itemCount: tugasSiswaList.length,
                itemBuilder: (context, index) {
                  var tugas = tugasSiswaList[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(tugas['materiId']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jawaban: ${tugas['jawaban']}'),
                          Text('Status: ${tugas['status']}'),
                          if (tugas['status'] == 'Dinilai')
                            Text('Nilai: ${tugas['nilai']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _beriNilai(context, tugas['materiId']),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _hapusTugas(context, tugas['materiId'], widget.namaSiswa),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}