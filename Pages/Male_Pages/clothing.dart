import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Clothing extends StatefulWidget {
  const Clothing({super.key});

  @override
  State<Clothing> createState() => _ClothingState();
}

class _ClothingState extends State<Clothing> {
  final List<Option> underwear = [
    Option(name: 'Men’s briefs', isSelected: false, value: 0.04),
    Option(name: 'Baniyan/undershirt', isSelected: false, value: 0.06),
  ];

  final List<Option> topwear = [
    Option(name: 'T-shirt', isSelected: false, value: 0.08),
    Option(name: 'Tie', isSelected: false, value: 0.01),
    Option(
        name: 'Short-Sleeved shirt/Kurta (Thin)',
        isSelected: false,
        value: 0.19),
    Option(
        name: 'Short-Sleeved shirt/Kurta (Thick)',
        isSelected: false,
        value: 0.28),
    Option(name: 'Long-sleeved shirt (Thin)', isSelected: false, value: 0.25),
    Option(name: 'Long-sleeved shirt (Thick)', isSelected: false, value: 0.34),
    Option(name: 'Jacket', isSelected: false, value: 0.36),
  ];

  final List<Option> bottomwear = [
    Option(name: 'Shorts', isSelected: false, value: 0.06),
    Option(name: 'Walking shorts', isSelected: false, value: 0.08),
    Option(
        name: 'Pants/Straight Trousers (Thin)', isSelected: false, value: 0.15),
    Option(
        name: 'Pants/Straight Trousers (Thick)',
        isSelected: false,
        value: 0.24),
  ];

  final List<Option> footwear = [
    Option(name: 'Ankle-length athletic socks', isSelected: false, value: 0.02),
    Option(name: 'Calf-length socks', isSelected: false, value: 0.03),
    Option(name: 'Knee socks (Thick)', isSelected: false, value: 0.06),
    Option(name: 'Shoes', isSelected: false, value: 0.02),
    Option(name: 'Chappals/Sandals/Thongs', isSelected: false, value: 0.02),
    Option(
        name: 'Slippers (Quilted, pile-lined)', isSelected: false, value: 0.03),
    Option(name: 'Boots', isSelected: false, value: 0.10),
  ];

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void _onOptionChanged(bool? value, int index, List<Option> options) {
    setState(() {
      options[index].isSelected = value ?? false;
    });
  }

  void _resetOptions() {
    setState(() {
      final allOptions = [...underwear, ...topwear, ...bottomwear, ...footwear];
      for (var option in allOptions) {
        option.isSelected = false;
      }
    });
  }

  double _calculateTotalValue() {
    double totalValue = 0;
    final allOptions = [...underwear, ...topwear, ...bottomwear, ...footwear];
    for (var option in allOptions) {
      if (option.isSelected) totalValue += option.value;
    }
    return totalValue;
  }

  Future<void> _submitData() async {
    // Calculate the total value and round it to 3 decimal places
    double totalValue = _calculateTotalValue();
    double roundedValue = double.parse(totalValue.toStringAsFixed(3));

    try {
      await _database.child("/D1/Application/Clothing Data/").update({
        'Clo value': roundedValue, 'Gen': '1'
        // Update other data if necessary
      });

      // Show confirmation
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data submitted',
          ),
        ),
      );
    } catch (error) {
      // Handle errors
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update data: $error',
          ),
        ),
      );
    }
  }

  Widget _buildOptionList(String title, List<Option> options,
      void Function(bool?, int) onChanged, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * 0.05, // Scaled based on screen width
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        ...options.asMap().entries.map(
              (entry) => ListTile(
                title: Text(
                  entry.value.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.04, // Scaled based on screen width
                  ),
                ),
                leading: Checkbox(
                  value: entry.value.isSelected,
                  onChanged: (bool? value) {
                    onChanged(value, entry.key);
                  },
                ),
              ),
            ),
        SizedBox(height: width * 0.05),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, // Adjust padding dynamically
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/Homepage");
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: width * 0.06, // Dynamic icon size
                    ),
                  ),
                  SizedBox(width: width * 0.1),
                  Text(
                    "Clothing Information",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05, // Dynamic text size
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              _buildOptionList(
                  'Underwear',
                  underwear,
                  (value, index) => _onOptionChanged(value, index, underwear),
                  width),
              _buildOptionList(
                  'Topwear',
                  topwear,
                  (value, index) => _onOptionChanged(value, index, topwear),
                  width),
              _buildOptionList(
                  'Bottomwear',
                  bottomwear,
                  (value, index) => _onOptionChanged(value, index, bottomwear),
                  width),
              _buildOptionList(
                  'Footwear',
                  footwear,
                  (value, index) => _onOptionChanged(value, index, footwear),
                  width),
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
            ],
          ),
        ),
      ),
    );
  }
}

class Option {
  final String name;
  bool isSelected;
  final double value;

  Option({
    required this.name,
    this.isSelected = false,
    required this.value,
  });
}
