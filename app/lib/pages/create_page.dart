import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateState extends StatefulWidget {
  const CreateState({super.key});

  @override
  State<CreateState> createState() => _CreateStateState();
}

class _CreateStateState extends State<CreateState> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  bool _obscurePassword = true;

  Future<http.Response> createUser(
      String username, String password, String nickname) async {
    final url = Uri.parse('http://localhost:8080/users');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'password': password,
      'nickname': nickname,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      return response;
    } catch (e) {
      // Handle exception
      print('Exception: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("REGISTER"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword, // Set this to a state variable
              decoration: InputDecoration(
                hintText: "Password",
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword =
                          !_obscurePassword; // Toggle the visibility state
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nicknameController,
              decoration: const InputDecoration(
                  hintText: "Nickname",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final password = passwordController.text;
                    final nickname = nicknameController.text;

                    if (username.isNotEmpty &&
                        password.isNotEmpty &&
                        nickname.isNotEmpty) {
                      final response =
                          await createUser(username, password, nickname);
                      if (response.statusCode == 200) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      } else {
                        usernameController.clear();
                        passwordController.clear();
                        nicknameController.clear();

                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text('Fail to create user'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'))
                                  ],
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content:
                                    const Text('Plese fill in all fields.'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'))
                                ],
                              ));
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
