import 'package:flutter/material.dart';

void _handleLogout(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  print('Back button pressed');
}

class AlluserPage extends StatelessWidget {
  const AlluserPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                  hintText: "Contact Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            const TextField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  hintText: "Contact Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Save')),
                ElevatedButton(onPressed: () {}, child: const Text('Update')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
