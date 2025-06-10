// lib/screens/edit_materi_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/gradient_background.dart'; // ⬅️ Import GradientBackground
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

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.materi['judul'];
    _deskripsiController.text = widget.materi['deskripsi'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Materi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground( // ✅ Diganti menjadi GradientBackground
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Material Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.book, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Material',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF948C7A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Title Field
              TextField(
                controller: _judulController,
                style: TextStyle(color: Colors.black), // Agar teks tetap terlihat jelas
                decoration: InputDecoration(
                  labelText: 'Title',
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
              SizedBox(height: 16),

              // Description Field
              TextField(
                controller: _deskripsiController,
                maxLines: 5,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Description',
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

              SizedBox(height: 24),

              // Tombol Save (belum ada, bisa ditambahkan nanti)
            ],
          ),
        ),
      ),
    );
  }
}