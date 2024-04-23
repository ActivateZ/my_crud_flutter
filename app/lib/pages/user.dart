import 'package:flutter/material.dart';

void _handleLogout(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  print('Back button pressed');
}

class UserPage extends StatelessWidget {
  const UserPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleLogout(context),
        ),
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
        ],
      ),
    );
  }
}
