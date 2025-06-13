import 'package:flutter/material.dart';
import 'package:sigesit/screens/edit_materi_screen.dart';
import 'package:sigesit/widgets/custom_sidebar.dart';
import 'package:sigesit/widgets/gradient_background.dart';
import 'package:sigesit/services/materi_service.dart';
import 'package:sigesit/screens/tambah_materi_screen.dart';
import 'package:sigesit/screens/detail_materi_screen.dart';

class MateriScreen extends StatefulWidget {
  @override
  _MateriScreenState createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  List<Map<String, dynamic>> daftarMateri = []; // Inisialisasi dengan list kosong
  final MateriService _materiService = MateriService();

  @override
  void initState() {
    super.initState();
    _loadMateri();
  }

  Future<void> _loadMateri() async {
    final materiList = await _materiService.getMateri();
    setState(() {
      daftarMateri = materiList;
    });
  }

  Future<void> _tambahMateri(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/tambah-materi');
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        daftarMateri.add(result);
      });
      await _materiService.saveMateri(daftarMateri); // Tambahkan await
    }
  }

  Future<void> _editMateri(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMateriScreen(materi: daftarMateri[index]),
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        daftarMateri[index] = result;
      });
      await _materiService.saveMateri(daftarMateri); // Tambahkan await
    }
  }

  Future<void> _hapusMateri(int index) async {
    setState(() {
      daftarMateri.removeAt(index);
    });
    await _materiService.saveMateri(daftarMateri); // Tambahkan await
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Materi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SideBar(),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => _tambahMateri(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF948C7A),
                    ),
                    icon: Icon(Icons.add),
                    label: Text('Create'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (daftarMateri.isEmpty)
                Center(
                  child: Text(
                    'Belum ada materi tersedia.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: daftarMateri.length,
                  itemBuilder: (context, index) {
                    final item = daftarMateri[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.description),
                        title: Text(item['judul'] ?? 'Judul Kosong'), // Handle null
                        subtitle: Text(item['deskripsi'] ?? 'Deskripsi Kosong'), // Handle null
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editMateri(context, index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _hapusMateri(index),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMateriScreen(materi: item),
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