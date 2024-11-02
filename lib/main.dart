import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false, home: const ProfileScreen());
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = "أنس الجهني",
      email = "anas@gmail.com",
      phone = "05999999999",
      address = "المدينة";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? fullName;
      email = prefs.getString('email') ?? email;
      phone = prefs.getString('phone') ?? phone;
      address = prefs.getString('address') ?? address;
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('address', address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 94, 120),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 40, color: Colors.white)),
            Text(fullName,
                style: const TextStyle(fontSize: 22, color: Colors.white)),
            Text(email,
                style: const TextStyle(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                        fullName: fullName,
                        email: email,
                        phone: phone,
                        address: address),
                  ),
                );
                if (result != null) {
                  setState(() {
                    fullName = result['fullName'];
                    email = result['email'];
                    phone = result['phone'];
                    address = result['address'];
                  });
                  _saveProfileData();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: const Text("Edit profile",
                  style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 30),
            _itemProfile("Name", fullName, Icons.person),
            _itemProfile("Phone", phone, Icons.phone),
            _itemProfile("Address", address, Icons.location_on),
            _itemProfile("Email", email, Icons.email),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Logout", style: TextStyle(color: Colors.red)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemProfile(String title, String subtitle, IconData iconData) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(fontSize: 20, color: Colors.yellow)),
      subtitle: Text(subtitle,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
      leading: Icon(iconData, color: Colors.yellow, size: 28),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  final String fullName, email, phone, address;

  const EditProfileScreen(
      {Key? key,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.address})
      : super(key: key);

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
                decoration: const InputDecoration(labelText: 'Phone')),
            TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address')),
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
