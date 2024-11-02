import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final String fullName, email, phone, address;

  const EditProfileScreen(
      {Key? key,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.address});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController(text: fullName);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);
    final addressController = TextEditingController(text: address);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name')),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Email')),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'fullName': fullNameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'address': addressController.text,
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
