import 'package:flutter/material.dart';

void _handleLogin(BuildContext context) {
  Navigator.pushNamed(context, '/alluser');
  print('Login button pressed');
}

void _handleSignUp(BuildContext context) {
  Navigator.pushNamed(context, '/createpage');
  print('Sign up button pressed');
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: const Text('CRUD'),
        backgroundColor: Colors.purple,
        elevation: 4.0,
        ),
        
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg1.jpg'),
                  fit: BoxFit.cover, // Adjust image size to fit container
                ),
              ),
            ),
          ),

          // Centered login container
          Center(
            child: Container(
              // Set a smaller size for the login container
              constraints: const BoxConstraints(
                maxWidth: 300, // Adjust width as needed
                maxHeight: 400, // Adjust height as needed
              ),
              decoration: const BoxDecoration(
                color: Colors.white, // Set container background color to white
                borderRadius: BorderRadius.all(
                    Radius.circular(20)), // Add rounded corners
              ),
              padding: const EdgeInsets.all(20), // Add padding around content
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Enter username",
                      labelText: "Username",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(height: 10),
                  // สร้างปุ่ม "ล็อกอิน"
                  ElevatedButton(
                    onPressed: () => _handleLogin(context),
                    child: const Text('LOGIN'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 16, // ปรับขนาดตัวอักษรที่ต้องการ
                      color: Color.fromARGB(255, 0, 0, 0), // ปรับสีตัวอักษรที่ต้องการ
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () => _handleSignUp(context),
                    child: const Text('SIGN UP'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
