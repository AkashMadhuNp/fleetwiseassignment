import 'package:flutter/material.dart';

class TruckImage extends StatelessWidget {
  const TruckImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
      top: screenHeight * 0.02,
      right: screenWidth * 0.3,
      child: Opacity(
        opacity: 0.5,
        child: Image.asset(
          "assets/Vector.png",
          height: screenHeight * 0.03,
          width: screenWidth * 0.1,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
