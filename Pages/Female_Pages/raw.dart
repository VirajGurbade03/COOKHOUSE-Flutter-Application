import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FClothing extends StatefulWidget {
  const FClothing({super.key});

  @override
  State<FClothing> createState() => FClothingState();
}

class FClothingState extends State<FClothing> {
  final List<Option> underwear = [
    Option(name: 'Bra', isSelected: false, value: 0.01),
    Option(name: 'Panties', isSelected: false, value: 0.03),
    Option(name: 'Petticoat', isSelected: false, value: 0.15),
  ];

  final List<Option> topwear = [
    Option(name: 'T-shirt', isSelected: false, value: 0.08),
    Option(name: 'Tie', isSelected: false, value: 0.01),
    Option(
        name: 'Short-Sleeved shirt/Kurti (Thin)',
        isSelected: false,
        value: 0.19),
    Option(
        name: 'Short-Sleeved shirt/Kurti (Thick)',
        isSelected: false,
        value: 0.28),
    Option(name: 'Long-sleeved shirt (Thin)', isSelected: false, value: 0.25),
    Option(name: 'Long-sleeved shirt (Thick)', isSelected: false, value: 0.34),
    Option(name: 'Blouse (for sari)', isSelected: false, value: 0.12),
    Option(name: 'Sleeveless', isSelected: false, value: 0.19),
    Option(name: 'Hijab (Thin)', isSelected: false, value: 0.6),
    Option(name: 'Hijab (Thick)', isSelected: false, value: 0.15),
    Option(name: 'Scarf/Dupatta (Thin)', isSelected: false, value: 0.04),
    Option(name: 'Scarf/Dupatta (Thick)', isSelected: false, value: 0.13),
  ];

  final List<Option> bottomwear = [
    Option(name: 'shorts', isSelected: false, value: 0.06),
    Option(name: 'Walking shorts', isSelected: false, value: 0.08),
    Option(
        name: 'Pants/ Straight Trousers (Thin)',
        isSelected: false,
        value: 0.15),
    Option(
        name: 'Pants/ Straight Trousers (Thick)',
        isSelected: false,
        value: 0.24),
    Option(
        name: 'Pajama/Salwar/churidar (thin)', isSelected: false, value: 0.13),
    Option(
        name: 'Pajama/Salwar/churidar (thick)', isSelected: false, value: 0.22),
    Option(name: 'Sari (thin,thick)', isSelected: false, value: 0.3),
  ];

  final List<Option> footwear = [
    Option(name: 'Ankle-length athletic socks', isSelected: false, value: 0.02),
    Option(name: 'Calf-length socks', isSelected: false, value: 0.03),
    Option(name: 'Knee socks (thick)', isSelected: false, value: 0.06),
    Option(name: 'Shoes', isSelected: false, value: 0.02),
    Option(name: 'Chappals/Sandals/thongs', isSelected: false, value: 0.02),
    Option(
        name: 'Slippers (quilted, pile-lined)', isSelected: false, value: 0.03),
    Option(name: 'Boots', isSelected: false, value: 0.10),
  ];

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void _onUnderwearChanged(bool? value, int index) {
    setState(() {
      underwear[index].isSelected = value ?? false;
    });
  }

  void _onTopwearChanged(bool? value, int index) {
    setState(() {
      topwear[index].isSelected = value ?? false;
    });
  }

  void _onBottomwearChanged(bool? value, int index) {
    setState(() {
      bottomwear[index].isSelected = value ?? false;
    });
  }

  void _onFootwearChanged(bool? value, int index) {
    setState(() {
      footwear[index].isSelected = value ?? false;
    });
  }

  void _resetOptions() {
    setState(() {
      for (var option in underwear) {
        option.isSelected = false;
      }
      for (var option in topwear) {
        option.isSelected = false;
      }
      for (var option in bottomwear) {
        option.isSelected = false;
      }
      for (var option in footwear) {
        option.isSelected = false;
      }
    });
  }

  double _calculateTotalValue() {
    double totalValue = 0;
    for (var option in underwear) {
      if (option.isSelected) totalValue += option.value;
    }
    for (var option in topwear) {
      if (option.isSelected) totalValue += option.value;
    }
    for (var option in bottomwear) {
      if (option.isSelected) totalValue += option.value;
    }
    for (var option in footwear) {
      if (option.isSelected) totalValue += option.value;
    }
    return totalValue;
  }

  Future<void> _submitData() async {
    double totalValue = _calculateTotalValue();
    double roundedValue = double.parse(totalValue.toStringAsFixed(3));

    try {
      await _database
          .child("/D1/Application/Clothing Data/")
          .update({'Clo value': roundedValue, 'Gen': '0'});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Total Value updated in database',
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update data: $error',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: height * 0.05, left: width * 0.05, bottom: height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/Homepage");
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 25), // Adjusted for responsiveness
                    Text(
                      "Clothing Information",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Underwear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: underwear
                      .asMap()
                      .entries
                      .map(
                        (entry) => ListTile(
                          title: Text(
                            entry.value.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Checkbox(
                            value: entry.value.isSelected,
                            onChanged: (bool? value) {
                              _onUnderwearChanged(value, entry.key);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Topwear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: topwear
                      .asMap()
                      .entries
                      .map(
                        (entry) => ListTile(
                          title: Text(
                            entry.value.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Checkbox(
                            value: entry.value.isSelected,
                            onChanged: (bool? value) {
                              _onTopwearChanged(value, entry.key);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bottomwear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: bottomwear
                      .asMap()
                      .entries
                      .map(
                        (entry) => ListTile(
                          title: Text(
                            entry.value.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Checkbox(
                            value: entry.value.isSelected,
                            onChanged: (bool? value) {
                              _onBottomwearChanged(value, entry.key);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Footwear',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: footwear
                      .asMap()
                      .entries
                      .map(
                        (entry) => ListTile(
                          title: Text(
                            entry.value.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          leading: Checkbox(
                            value: entry.value.isSelected,
                            onChanged: (bool? value) {
                              _onFootwearChanged(value, entry.key);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width * 0.4, // Responsive button size
                        height: height * 0.06,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: CupertinoButton(
                          onPressed: _submitData,
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 60, 60, 60),
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.4, // Responsive button size
                        height: height * 0.06,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: CupertinoButton(
                          onPressed: _resetOptions,
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 60, 60, 60),
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Option {
  String name;
  bool isSelected;
  double value;

  Option({required this.name, required this.isSelected, required this.value});
}
