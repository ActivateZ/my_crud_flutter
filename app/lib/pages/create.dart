import 'package:flutter/material.dart';

void _handleBack(BuildContext context) {
 Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
 print('Back button pressed');
}

void _handleSignUp(BuildContext context) {
 Navigator.pushNamed(context, '/user');
 print('Sign up button pressed');
}

class CreatePage extends StatelessWidget {
 const CreatePage({super.key});

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: _buildAppBar(context),
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
                   "ICON",
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
                 const TextField(
                   decoration: InputDecoration(
                     hintText: "Enter nickname",
                     labelText: "Nickname",
                   ),
                 ),
                 const SizedBox(height: 10),
                 ElevatedButton(
                   onPressed: () => _handleSignUp(context),
                   child: const Text('Sign UP'),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );
 }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
   return AppBar(
     centerTitle: true,
     title: const Text('Sign Up'),
     leading: IconButton(
       icon: const Icon(Icons.arrow_back),
       onPressed: () => _handleBack(context),
     ),
   );
 }
}