import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(
          '/SignIn'); // Navigate to SignIn page and clear navigation stack
    } catch (e) {
      print('Error during logout: $e'); // Add error handling
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color.fromRGBO(116, 116, 116, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.white),
            title: const Text('Account', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to account settings page
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.white),
            title: const Text('Notifications',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to notifications settings page
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.white),
            title: const Text('Privacy', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to privacy settings page
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.language, color: Colors.white),
            title:
                const Text('Language', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to language settings page
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.help, color: Colors.white),
            title: const Text('Help', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to help settings page
            },
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text('About', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to about settings page
            },
          ),
          const Divider(color: Colors.white),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _logout, // Call the logout method
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
