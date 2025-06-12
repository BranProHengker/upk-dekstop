// lib/widgets/siswa_sidebar.dart

import 'package:flutter/material.dart';

class SiswaSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF948C7A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header dengan Avatar
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF948C7A)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/profile_siswa.png'), // Ganti dengan foto dinamis jika ada
                ),
                SizedBox(height: 12),
                Text(
                  'Andi Pratama',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Kelas 7A',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Menu Dashboard
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Dashboard', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/dashboard/siswa');
            },
          ),

          // Menu Materi
          ListTile(
            leading: Icon(Icons.menu_book, color: Colors.white),
            title: Text('Materi', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/siswa/materi');
            },
          ),
      
          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}