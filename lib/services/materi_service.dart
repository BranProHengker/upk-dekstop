import 'package:shared_preferences/shared_preferences.dart';

class MateriService {
  static const String _keyMateri = 'daftarMateri';

  Future<void> saveMateri(List<Map<String, dynamic>> materiList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedList = materiList
        .map((materi) => '${materi['judul']}|${materi['deskripsi']}')
        .toList();
    await prefs.setStringList(_keyMateri, encodedList);
  }

  Future<List<Map<String, dynamic>>> getMateri() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keyMateri) ?? [];

    return list.map((item) {
      final parts = item.split('|');
      if (parts.length < 2) {
        return {'judul': 'Invalid', 'deskripsi': 'Data tidak valid'};
      }
      return {'judul': parts[0], 'deskripsi': parts[1]};
    }).toList();
  }

  Future<void> clearMateri() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyMateri);
  }
}