import 'package:flutter/material.dart';

class TopDesign extends StatelessWidget {
  const TopDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Image.asset(
        "assets/topcorner.png",
        height: 164,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}