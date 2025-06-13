// lib/services/tugas_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TugasService {
  // Key untuk menyimpan daftar tugas di SharedPreferences
  static const String _keyTugas = 'tugas_list';

  /// Simpan atau update tugas siswa (boleh submit ulang)
  Future<void> simpanTugas(String idMateri, String namaSiswa, String jawaban) async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil list tugas yang sudah ada atau buat baru
    List<String>? savedList = prefs.getStringList(_keyTugas);

    List<Map<String, dynamic>> tugasList =
        savedList?.map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr))).toList() ?? [];

    // Hapus tugas lama dari siswa ini untuk materi tertentu
    tugasList.removeWhere((task) => task['materiId'] == idMateri && task['siswa'] == namaSiswa);

    // Buat tugas baru
    final newTask = {
      'materiId': idMateri,
      'siswa': namaSiswa,
      'jawaban': jawaban,
      'status': 'Belum Dinilai',
      'nilai': 0,
    };

    tugasList.add(newTask);

    // Simpan kembali ke SharedPreferences
    List<String> encodedList = tugasList.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList(_keyTugas, encodedList);
  }

  /// Ambil semua tugas berdasarkan id materi
  Future<List<Map<String, dynamic>>> getTugasByMateri(String idMateri) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList(_keyTugas);

    if (savedList == null || savedList.isEmpty) {
      return [];
    }

    List<Map<String, dynamic>> allTasks =
        savedList.map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr))).toList();

    // Filter tugas sesuai idMateri
    return allTasks.where((task) => task['materiId'] == idMateri).toList();
  }

  /// Beri nilai pada tugas tertentu
  Future<void> beriNilai(String idMateri, String namaSiswa, int nilai) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList(_keyTugas);

    if (savedList == null || savedList.isEmpty) return;

    List<Map<String, dynamic>> tugasList =
        savedList.map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr))).toList();

    for (var task in tugasList) {
      if (task['materiId'] == idMateri && task['siswa'] == namaSiswa) {
        task['status'] = 'Dinilai';
        task['nilai'] = nilai;
      }
    }

    // Simpan kembali ke SharedPreferences
    List<String> encodedList = tugasList.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList(_keyTugas, encodedList);
  }

  /// Ambil semua tugas tanpa filter
  Future<List<Map<String, dynamic>>> getAllTugasSiswa() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList(_keyTugas);

    if (savedList == null || savedList.isEmpty) {
      return [];
    }

    return savedList
        .map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr)))
        .toList();
  }

  /// Ambil semua tugas berdasarkan nama siswa
  Future<List<Map<String, dynamic>>> getTugasBySiswa(String namaSiswa) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList(_keyTugas);

    if (savedList == null || savedList.isEmpty) {
      return [];
    }

    List<Map<String, dynamic>> allTasks =
        savedList.map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr))).toList();

    return allTasks.where((task) => task['siswa'] == namaSiswa).toList();
  }

  /// Hapus tugas berdasarkan idMateri dan namaSiswa
  Future<void> hapusTugas(String idMateri, String namaSiswa) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedList = prefs.getStringList(_keyTugas);

    if (savedList == null || savedList.isEmpty) return;

    List<Map<String, dynamic>> tugasList =
        savedList.map((jsonStr) => Map<String, dynamic>.from(jsonDecode(jsonStr))).toList();

    // Hapus tugas yang sesuai
    tugasList.removeWhere((task) => task['materiId'] == idMateri && task['siswa'] == namaSiswa);

    // Simpan kembali ke SharedPreferences
    List<String> encodedList = tugasList.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList(_keyTugas, encodedList);
  }
}