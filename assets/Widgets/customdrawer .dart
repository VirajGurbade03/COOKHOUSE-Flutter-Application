import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure you have GetX package if using Get.toNamed

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: const Color(0xFF4D4B4B),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF4D4B4B),
            ),
            child: Text(
              'ComfortCast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.devices_other_sharp),
          //   title: const Text('Devices Connected'),
          //   onTap: () {
          //     Navigator.pushNamed(context, "/DevicesPage");
          //   },
          // ),
          ExpansionTile(
            leading: const Icon(Icons.dry_cleaning),
            title: const Text('Clothing'),
            children: [
              ListTile(
                leading: const Icon(Icons.male),
                title: const Text('Male'),
                onTap: () {
                  Navigator.pushNamed(context, "/Clothing");
                },
              ),
              ListTile(
                leading: const Icon(Icons.female),
                title: const Text('Female'),
                onTap: () {
                  Navigator.pushNamed(context, "/FClothing");
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.directions_run_outlined),
            title: const Text('Activity'),
            onTap: () {
              Navigator.pushNamed(context, "/ActivityPage");
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_link_rounded),
            title: const Text('Connection'),
            onTap: () {
              Navigator.pushNamed(context, "/Connection");
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessibility_new),
            title: const Text('BMI'),
            onTap: () {
              Navigator.pushNamed(context, "/BMIpage");
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_chart_sharp),
            title: const Text('Model Output'),
            onTap: () {
              Navigator.pushNamed(context, "/Modeloutput");
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Get.toNamed('/ProfilePage'); // Use Get.toNamed for navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () {
              Navigator.pushNamed(context, "/SettingPage");
            },
          ),
        ],
      ),
    );
  }
}
