// lib/screens/detail_materi_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/gradient_background.dart';

class DetailMateriScreen extends StatelessWidget {
  final Map<String, dynamic> materi;

  DetailMateriScreen({required this.materi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Materi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                materi['judul'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                materi['deskripsi'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}