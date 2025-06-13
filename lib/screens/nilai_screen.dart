import 'package:flutter/material.dart';
import 'package:sigesit/services/tugas_service.dart';
import 'package:sigesit/widgets/gradient_background.dart';
import 'package:sigesit/widgets/custom_sidebar.dart'; // ✅ Import sidebar admin

class NilaiScreen extends StatefulWidget {
  @override
  _NilaiScreenState createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State<NilaiScreen> {
  List<Map<String, dynamic>> daftarTugas = [];
  final TugasService _tugasService = TugasService();

  Future<void> _loadTugas() async {
    try {
      final tugasList = await _tugasService.getTugasByMateri('Matematika - Bab 1'); // Ganti dengan ID dinamis nanti
      print('Fetched tasks: $tugasList'); // Debug statement
      setState(() {
        daftarTugas = tugasList;
      });
    } catch (e) {
      print('Error loading tasks: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat tugas')),
      );
    }
  }

  void _beriNilai(BuildContext context, String namaSiswa, String idMateri) {
    TextEditingController _nilaiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Beri Nilai untuk $namaSiswa'),
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
                    await _tugasService.beriNilai(idMateri, namaSiswa, nilai);
                    Navigator.pop(context); // Tutup dialog
                    _loadTugas(); // Refresh UI
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
      drawer: SideBar(), // Sidebar khusus admin
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tugas: Matematika - Bab 1',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
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
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: daftarTugas.isEmpty
                    ? Center(
                        child: Text(
                          'Tidak ada tugas yang tersedia.',
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
                                backgroundImage: NetworkImage('https://source.unsplash.com/random/100x100/?student'),
                              ),
                              title: Text(item['siswa']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['jawaban']),
                                  SizedBox(height: 4),
                                  Text(
                                    item['status'],
                                    style: TextStyle(
                                      color: item['status'] == 'Dinilai' ? Colors.green : Colors.orange,
                                    ),
                                  ),
                                  if (item['status'] == 'Dinilai')
                                    Text('Nilai: ${item['nilai']}'),
                                ],
                              ),
                              trailing: item['status'] == 'Dinilai'
                                  ? Text('${item['nilai']}', style: TextStyle(fontWeight: FontWeight.bold))
                                  : IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => _beriNilai(context, item['siswa'], item['materiId']),
                                    ),
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