import 'package:flutter/material.dart';
import 'package:sigesit/services/materi_service.dart';
import 'package:sigesit/widgets/siswa_sidebar.dart'; 
import 'package:sigesit/widgets/gradient_background.dart';


class SiswaMateriScreen extends StatefulWidget {
  final String? username;

  const SiswaMateriScreen({Key? key, this.username}) : super(key: key);

  @override
  _SiswaMateriScreenState createState() => _SiswaMateriScreenState();
}

class _SiswaMateriScreenState extends State<SiswaMateriScreen> {
  List<Map<String, dynamic>> daftarMateri = [];
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

  void _lihatDetail(BuildContext context, Map<String, dynamic> item) {
    Navigator.pushNamed(
      context,
      '/detail-materi-siswa',
      arguments: {
        'materi': item,
        'username': widget.username,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materi Pelajaran'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SiswaSideBar(), // Pastikan SideBar di-import
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar Materi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: daftarMateri.length,
                  itemBuilder: (context, index) {
                    var item = daftarMateri[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage('https://source.unsplash.com/random/100x100/?education'),
                        ),
                        title: Text(item['judul']),
                        subtitle: Text(item['deskripsi']),
                        onTap: () => _lihatDetail(context, item),
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