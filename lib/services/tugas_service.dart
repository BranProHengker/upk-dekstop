import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TugasService {
  static const String _keyTugas = 'tugas_list';

  // Menyimpan tugas baru atau mengupdate jika sudah ada
  Future<bool> simpanTugas(String idMateri, String namaSiswa, String jawaban) async {
  try {
    print('Menyimpan tugas - MateriID: $idMateri, Siswa: $namaSiswa'); // Debug
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> tugasList = await _getAllTugas(prefs);

    final existingIndex = tugasList.indexWhere(
      (task) => task['materiId'] == idMateri && task['siswa'] == namaSiswa
    );

    final newTask = {
      'materiId': idMateri,
      'siswa': namaSiswa,
      'jawaban': jawaban,
      'status': existingIndex != -1 ? tugasList[existingIndex]['status'] : 'Belum Dinilai',
      'nilai': existingIndex != -1 ? tugasList[existingIndex]['nilai'] : 0,
      'lastUpdated': DateTime.now().toIso8601String(),
    };

    if (existingIndex != -1) {
      tugasList[existingIndex] = newTask;
      print('Update tugas yang sudah ada'); // Debug
    } else {
      tugasList.add(newTask);
      print('Menambahkan tugas baru'); // Debug
    }

    final result = await _saveAllTugas(prefs, tugasList);
    print('Penyimpanan ${result ? 'berhasil' : 'gagal'}'); // Debug
    return result;
  } catch (e) {
    print('Error simpanTugas: $e');
    return false;
  }
}

  // Mendapatkan semua tugas untuk materi tertentu
  Future<List<Map<String, dynamic>>> getTugasByMateri(String idMateri) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allTasks = await _getAllTugas(prefs);
      return allTasks.where((task) => task['materiId'] == idMateri).toList();
    } catch (e) {
      print('Error getTugasByMateri: $e');
      return [];
    }
  }

  // Mendapatkan tugas spesifik siswa untuk materi tertentu
  Future<Map<String, dynamic>?> getTugasSiswa(String idMateri, String namaSiswa) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allTasks = await _getAllTugas(prefs);
      return allTasks.firstWhere(
        (task) => task['materiId'] == idMateri && task['siswa'] == namaSiswa,
        orElse: () => {},
      );
    } catch (e) {
      print('Error getTugasSiswa: $e');
      return null;
    }
  }

  // Memeriksa apakah siswa sudah mengerjakan tugas
  Future<bool> sudahMengerjakan(String idMateri, String namaSiswa) async {
    final tugas = await getTugasSiswa(idMateri, namaSiswa);
    return tugas != null && tugas.isNotEmpty;
  }

  // Memberi nilai pada tugas siswa
  Future<bool> beriNilai(String idMateri, String namaSiswa, int nilai) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tugasList = await _getAllTugas(prefs);
      
      final index = tugasList.indexWhere(
        (task) => task['materiId'] == idMateri && task['siswa'] == namaSiswa
      );

      if (index == -1) return false;

      tugasList[index]['status'] = 'Dinilai';
      tugasList[index]['nilai'] = nilai;
      tugasList[index]['lastUpdated'] = DateTime.now().toIso8601String();

      return await _saveAllTugas(prefs, tugasList);
    } catch (e) {
      print('Error beriNilai: $e');
      return false;
    }
  }

  // ============ HELPER METHODS ============
  
  Future<List<Map<String, dynamic>>> _getAllTugas(SharedPreferences prefs) async {
    final savedList = prefs.getStringList(_keyTugas) ?? [];
    return savedList.map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr))).toList();
  }

  Future<bool> _saveAllTugas(SharedPreferences prefs, List<Map<String, dynamic>> tugasList) async {
    try {
      final encodedList = tugasList.map((task) => jsonEncode(task)).toList();
      return await prefs.setStringList(_keyTugas, encodedList);
    } catch (e) {
      print('Error _saveAllTugas: $e');
      return false;
    }
  }

  // Menghapus semua data tugas (untuk testing/debugging)
  Future<void> clearAllTugas() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyTugas);
  }
}