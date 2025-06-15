import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SexPage extends StatefulWidget {
  const SexPage({super.key});

  @override
  State<SexPage> createState() => SexPageState();
}

class SexPageState extends State<SexPage> {
  bool isFemaleSelected = false;
  bool isMaleSelected = false;

  @override
  void initState() {
    super.initState();
    loadGenderSelection();
  }

  Future<void> loadGenderSelection() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isMaleSelected = prefs.getBool('isMaleSelected') ?? false;
      isFemaleSelected = prefs.getBool('isFemaleSelected') ?? false;
    });

    // Print the stored gender value to the terminal
    String? gender = prefs.getString('selectedGender');
    if (gender != null) {
      print('Stored gender: $gender');
    } else {
      print('No gender stored.');
    }
  }

  Future<void> saveGenderSelection(
      bool isMaleSelected, bool isFemaleSelected) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMaleSelected', isMaleSelected);
    await prefs.setBool('isFemaleSelected', isFemaleSelected);

    // Save selected gender for navigation on app restart
    String gender = isMaleSelected ? 'Male' : 'Female';
    await prefs.setString('selectedGender', gender);
  }

  void selectFemale() {
    setState(() {
      isFemaleSelected = true;
      isMaleSelected = false;
    });
  }

  void selectMale() {
    setState(() {
      isMaleSelected = true;
      isFemaleSelected = false;
    });
  }

  Future<void> saveGenderData(String gender) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set(
        {
          'gender': gender,
        },
        SetOptions(merge: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String? email = arguments?['email'];

    // Use the email to retrieve the user's data from Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((value) {
      if (value.exists) {
        // Use the user's data to display the sex page
      } else {
        // Handle the case where the user's data does not exist
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double imageSize =
              screenWidth * 0.4; // Adjust image size based on width
          double fontSize = screenWidth * 0.08; // Adjust font size dynamically
          double buttonWidth = screenWidth * 0.7;
          double buttonHeight = screenHeight * 0.08;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    "Please select your\n        “Gender”\n      information",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  GestureDetector(
                    onTap: selectFemale,
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isFemaleSelected
                              ? Colors.pink
                              : Colors.transparent,
                          width: 3,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('lib/assets/images/Female.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Female",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize * 0.6,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  GestureDetector(
                    onTap: selectMale,
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isMaleSelected ? Colors.blue : Colors.transparent,
                          width: 3,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('lib/assets/images/Male.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Male",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize * 0.6,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5F5F5F),
                      borderRadius: BorderRadius.circular(39.95),
                    ),
                    child: CupertinoButton(
                      onPressed: () async {
                        if (isFemaleSelected || isMaleSelected) {
                          String gender = isMaleSelected ? 'Male' : 'Female';
                          await saveGenderData(gender);
                          await saveGenderSelection(
                              isMaleSelected, isFemaleSelected);

                          Navigator.pushNamed(context, "/Homepage");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your gender.'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize * 0.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SexPage extends StatefulWidget {
//   const SexPage({super.key});

//   @override
//   State<SexPage> createState() => SexPageState();
// }

// class SexPageState extends State<SexPage> {
//   bool isFemaleSelected = false;
//   bool isMaleSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     loadGenderSelection();
//   }

//   Future<void> loadGenderSelection() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isMaleSelected = prefs.getBool('isMaleSelected') ?? false;
//       isFemaleSelected = prefs.getBool('isFemaleSelected') ?? false;
//     });

//     // Print the stored gender value to the terminal
//     String? gender = prefs.getString('selectedGender');
//     if (gender != null) {
//       print('Stored gender: $gender');
//     } else {
//       print('No gender stored.');
//     }
//   }

//   Future<void> saveGenderSelection(
//       bool isMaleSelected, bool isFemaleSelected) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isMaleSelected', isMaleSelected);
//     await prefs.setBool('isFemaleSelected', isFemaleSelected);

//     // Save selected gender for navigation on app restart
//     String gender = isMaleSelected ? 'Male' : 'Female';
//     await prefs.setString('selectedGender', gender);
//   }

//   void selectFemale() {
//     setState(() {
//       isFemaleSelected = true;
//       isMaleSelected = false;
//     });
//   }

//   void selectMale() {
//     setState(() {
//       isMaleSelected = true;
//       isFemaleSelected = false;
//     });
//   }

//   Future<void> saveGenderData(String gender) async {
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       await FirebaseFirestore.instance.collection('Users').doc(user.uid).set(
//         {
//           'gender': gender,
//         },
//         SetOptions(merge: true),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final arguments =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     String? email = arguments?['email'];

//     // Use the email to retrieve the user's data from Firestore
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(email)
//         .get()
//         .then((value) {
//       if (value.exists) {
//         // Use the user's data to display the sex page
//       } else {
//         // Handle the case where the user's data does not exist
//       }
//     });

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 120),
//             const Text(
//               "Please select your\n        “Gender”\n      information",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 33.51,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//             ),
//             const SizedBox(height: 30),
//             GestureDetector(
//               onTap: selectFemale,
//               child: Container(
//                 width: 154,
//                 height: 154,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: isFemaleSelected ? Colors.pink : Colors.transparent,
//                     width: 3,
//                   ),
//                   image: const DecorationImage(
//                     image: AssetImage('lib/assets/images/Female.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 5),
//             const Text(
//               "Female",
//               style: TextStyle(
//                 color: Colors.pink,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25,
//               ),
//             ),
//             const SizedBox(height: 60),
//             GestureDetector(
//               onTap: selectMale,
//               child: Container(
//                 width: 154,
//                 height: 154,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: isMaleSelected ? Colors.blue : Colors.transparent,
//                     width: 3,
//                   ),
//                   image: const DecorationImage(
//                     image: AssetImage('lib/assets/images/Male.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 7),
//             const Text(
//               "Male",
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: 300,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF5F5F5F),
//                 borderRadius: BorderRadius.circular(39.95),
//               ),
//               child: CupertinoButton(
//                 onPressed: () async {
//                   if (isFemaleSelected || isMaleSelected) {
//                     String gender = isMaleSelected ? 'Male' : 'Female';
//                     await saveGenderData(gender);
//                     await saveGenderSelection(isMaleSelected, isFemaleSelected);

//                     Navigator.pushNamed(context, "/Homepage");
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Please select your gender.'),
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text(
//                   'Next',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
