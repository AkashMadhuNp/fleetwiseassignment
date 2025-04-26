import 'package:flutter/material.dart';

class TopDesign extends StatelessWidget {
  const TopDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Opacity(
      opacity: isDarkMode ? 0.7 : 0.5, // Increase opacity for dark mode visibility
      child: Image.asset(
        isDarkMode ? "assets/topcorner.png" : "assets/topcorner.png",
        height: 164,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}