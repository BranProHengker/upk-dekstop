import 'package:flutter/material.dart';
import 'package:sigesit/widgets/gradient_background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<Map<String, dynamic>> userList = [
    {'name': 'admin', 'password': 'admin', 'role': 'guru'},
    {'name': 'andi', 'password': 'siswa', 'role': 'siswa'},
    {'name': 'osis', 'password': 'osis123', 'role': 'osis'},
  ];

  void _login(BuildContext context) {
    String name = _nameController.text;
    String password = _passwordController.text;

    if (name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua field harus diisi')),
      );
      return;
    }

    final matches = userList
        .where((u) => u['name'] == name && u['password'] == password)
        .toList();

    if (matches.isNotEmpty) {
      final user = matches.first;
      switch (user['role']) {
        case 'guru':
          Navigator.pushReplacementNamed(context, '/dashboard');
          break;
        case 'siswa':
          Navigator.pushReplacementNamed(context, '/dashboard/siswa');
          break;
        case 'osis':
          Navigator.pushReplacementNamed(context, '/dashboard/osis');
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role tidak dikenali')),
          );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nama atau Password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 360,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 235, 200, 1), // ⬅ Warna cardbox lebih soft
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(3, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 30),

                  // Name input
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withOpacity(0.4),
                          blurRadius: 4,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  // Password input
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withOpacity(0.4),
                          blurRadius: 4,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),

                  // Login button
                  ElevatedButton(
                    onPressed: () => _login(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF948C7A), // Tombol tetap sesuai tema
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shadowColor: Colors.grey.shade500,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}