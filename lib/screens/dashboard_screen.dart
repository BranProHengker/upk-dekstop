// lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:sigesit/widgets/custom_sidebar.dart';
import 'package:sigesit/widgets/gradient_background.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SideBar(),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selamat Datang dengan Avatar
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://source.unsplash.com/random/100x100/?profile',
                      ),
                      radius: 30,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang, Admin 👋',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'Berikut adalah ringkasan data hari ini.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),

                // Statistik Utama
                Text(
                  'Statistik',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(title: 'Total Siswa', count: '120 Siswa', icon: Icons.person),
                    _buildStatCard(title: 'Total Kelas', count: '21 Kelas', icon: Icons.school),
                    _buildStatCard(title: 'Total Guru', count: '120 Guru', icon: Icons.people_alt),
                  ],
                ),

                SizedBox(height: 30),

                // Aktivitas Terbaru
                Text(
                  'Aktivitas Terbaru',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                _buildRecentActivity(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi Membuat Card Statistik
  Widget _buildStatCard({required String title, required String count, required IconData icon}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF948C7A), size: 30),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(count, style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Aktivitas Terbaru
  Widget _buildRecentActivity(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        final activities = [
          {
            'title': 'Materi baru ditambahkan',
            'subtitle': 'Matematika - Bab 3 Aljabar'
          },
          {
            'title': 'Siswa baru terdaftar',
            'subtitle': 'Nama: Andi Putra'
          },
          {
            'title': 'Nilai dirilis',
            'subtitle': 'Bahasa Indonesia - Kelas XI'
          },
          {
            'title': 'Pengumuman baru',
            'subtitle': 'Ujian tengah semester dimulai besok.'
          },
        ];

        var item = activities[index];

        return Card(
          color: Colors.white.withOpacity(0.9),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(Icons.notifications, color: Color(0xFF948C7A)),
            title: Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['subtitle']!),
          ),
        );
      },
    );
  }
}