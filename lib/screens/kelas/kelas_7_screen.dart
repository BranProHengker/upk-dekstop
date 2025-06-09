import 'package:flutter/material.dart';
import 'package:sigesit/widgets/custom_sidebar.dart'; // Sidebar
import 'package:sigesit/screens/kelas/kelas_7a_screen.dart'; // Halaman Kelas 7A

class Kelas7Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Jurusan'),
        backgroundColor: Color(0xFFD1BB9E),
        elevation: 0,
      ),
      drawer: SideBar(), // Sidebar template
      body: Padding(
        padding: const EdgeInsets.all(8.0), // ⬇️ Padding dikurangi jadi 8
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8, // ⬇️ Spacing antar baris dikurangi
          crossAxisSpacing: 8, // ⬇️ Spacing antar kolom dikurangi
          children: List.generate(7, (index) {
            final jurusan = '7${String.fromCharCode(65 + index)}'; // 7A, 7B, dst.
            return ElevatedButton(
              onPressed: () {
                if (jurusan == '7A') {
                  Navigator.pushNamed(context, '/kelas/7A'); // Navigasi ke halaman Kelas 7A
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$jurusan belum tersedia')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 8, // ⬇️ Padding vertikal dikurangi
                  horizontal: 12, // ⬇️ Padding horizontal tetap
                ),
                minimumSize: Size(80, 80), // ⬇️ Ukuran minimal tombol
                maximumSize: Size(120, 120), // ⬇️ Ukuran maksimal tombol
              ),
              child: Center(
                child: Text(
                  jurusan,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}