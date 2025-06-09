import 'package:flutter/material.dart';
import 'package:sigesit/services/materi_service.dart';

class EditMateriScreen extends StatefulWidget {
  final Map<String, dynamic> materi;

  const EditMateriScreen({Key? key, required this.materi}) : super(key: key);

  @override
  _EditMateriScreenState createState() => _EditMateriScreenState();
}

class _EditMateriScreenState extends State<EditMateriScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final MateriService _materiService = MateriService();

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.materi['judul'];
    _deskripsiController.text = widget.materi['deskripsi'] ?? '';
  }

  void _simpanPerubahan(BuildContext context) {
    String judul = _judulController.text;
    String deskripsi = _deskripsiController.text;

    if (judul.isEmpty || deskripsi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Judul dan Deskripsi harus diisi')),
      );
      return;
    }

    final updatedMateri = {
      'judul': judul,
      'deskripsi': deskripsi,
    };

    Navigator.pop(context, updatedMateri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Materi'),
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
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _simpanPerubahan(context),
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