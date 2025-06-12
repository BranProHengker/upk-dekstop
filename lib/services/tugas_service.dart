import 'package:shared_preferences/shared_preferences.dart';

class TugasService {
  static const String _keyTugas = 'daftarTugas'; // Format: idMateri|namaSiswa|jawaban|status|nilai

  Future<void> simpanTugas(String idMateri, String namaSiswa, String jawaban) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keyTugas) ?? [];

    final tugasBaru = '$idMateri|$namaSiswa|$jawaban|Belum Dinilai|0';
    list.add(tugasBaru);

    await prefs.setStringList(_keyTugas, list);
  }

  Future<List<Map<String, dynamic>>> getTugasByMateri(String idMateri) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keyTugas) ?? [];

    return list
        .where((item) => item.split('|')[0] == idMateri)
        .map((item) {
          final parts = item.split('|');
          return {
            'materiId': parts[0],
            'siswa': parts[1],
            'jawaban': parts[2],
            'status': parts[3],
            'nilai': parts.length > 4 ? parts[4] : '0',
          };
        }).toList();
  }

  Future<void> beriNilai(String idMateri, String namaSiswa, int nilai) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keyTugas) ?? [];

    final updatedList = list.map((item) {
      final parts = item.split('|');
      if (parts[0] == idMateri && parts[1] == namaSiswa) {
        return '$idMateri|$namaSiswa|${parts[2]}|Dinilai|$nilai';
      }
      return item;
    }).toList();

    await prefs.setStringList(_keyTugas, updatedList);
  }
}