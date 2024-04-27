import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_1/model/alluser_model.dart';
import 'package:http/http.dart' as http;

class AllzUser extends StatefulWidget {
  const AllzUser({super.key});

  @override
  State<AllzUser> createState() => _AllzUserState();
}

class _AllzUserState extends State<AllzUser> {
  int? editingIndex;
  bool isAdding = false;
  bool isEditing = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  // For holding response as UserPets
  late AllUser allUser;
  // for data is loaded flag
  bool isDataLoaded = false;
  // error holding
  String errorMessage = '';

  // API Call
  Future<AllUser> getDataFromAPI() async {
    Uri uri = Uri.parse('http://localhost:8080/users');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      // All ok
      AllUser allUser = allUserFromJson(response.body);
      setState(() {
        isDataLoaded = true;
      });
      return allUser;
    } else {
      errorMessage = '${response.statusCode}: ${response.body} ';
      return AllUser(users: []);
    }
  }

  callAPIandAssignData() async {
    allUser = await getDataFromAPI();
  }

  @override
  void initState() {
    callAPIandAssignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              isAdding
                  ? Column(
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
                          decoration: const InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ))),
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

                                final response = await http.post(
                                  Uri.parse('http://localhost:8080/users'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'username': username,
                                    'password': password,
                                    'nickname': nickname,
                                  }),
                                );

                                if (response.statusCode == 200) {
                                  // User created successfully
                                  usernameController.clear();
                                  passwordController.clear();
                                  nicknameController.clear();
                                  // Call the API again to refresh the data
                                  callAPIandAssignData();
                                } else {
                                  // Handle the error case
                                  print('Error: ${response.statusCode}');
                                }
                              },
                              child: const Text('Create'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                isAdding = false;
                                usernameController.clear();
                                passwordController.clear();
                                nicknameController.clear();
                                setState(() {});
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              isEditing
                  ? Column(
                      children: [
                        TextField(
                          controller: nicknameController,
                          decoration: const InputDecoration(
                              hintText: "Nickname",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final index = editingIndex!;
                                final user = allUser.users[index];

                                final nickname = nicknameController.text;

                                final response = await http.put(
                                  Uri.parse(
                                      'http://localhost:8080/users/${user.id}'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, String>{
                                    'nickname': nickname,
                                  }),
                                );

                                if (response.statusCode == 200) {
                                  // User updated successfully
                                  usernameController.clear();
                                  nicknameController.clear();
                                  editingIndex = null;
                                  // Call the API again to refresh the data
                                  callAPIandAssignData();
                                } else {
                                  // Handle the error case
                                  print('Error: ${response.statusCode}');
                                }
                              },
                              child: const Text('Update'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                isEditing = false;
                                usernameController.clear();
                                passwordController.clear();
                                nicknameController.clear();
                                setState(() {});
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              isDataLoaded
                  ? errorMessage.isNotEmpty
                      ? Text(errorMessage)
                      : allUser.users.isEmpty
                          ? const Text('No Data')
                          : Expanded(
                              child: ListView.builder(
                                itemCount: allUser.users.length,
                                itemBuilder: (context, index) => getRow(index),
                              ),
                            )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isEditing = false;
          isAdding = true;
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                allUser.users[index].username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(
                allUser.users[index].nickname,
              ),
            ],
          ),
          trailing: SizedBox(
            width: 60,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      isAdding = false;
                      isEditing = true;
                      editingIndex = index;
                      usernameController.text = allUser.users[index].username;
                      nicknameController.text = allUser.users[index].nickname;
                      setState(() {});
                    },
                    child: const Icon(Icons.edit)),
                const SizedBox(width: 10),
                InkWell(
                    onTap: () async {
                      final user = allUser.users[index];

                      final response = await http.delete(
                        Uri.parse('http://localhost:8080/users/${user.id}'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                      );

                      if (response.statusCode == 200) {
                        // User deleted successfully
                        // Call the API again to refresh the data
                        callAPIandAssignData();
                      } else {
                        // Handle the error case
                        print('Error: ${response.statusCode}');
                      }
                    },
                    child: const Icon(Icons.delete)),
              ],
            ),
          )),
    );
  }
}
