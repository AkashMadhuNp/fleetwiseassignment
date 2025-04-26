import 'package:fleetwise/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.044, top: size.height * 0.02), // 16/360, 16/800
          child: Text(
            "What you get on FleetWise:",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: AppColors.blueText,
              fontSize: size.width * 0.05, // 18/360
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.022), // 8/360
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/Earningtracking.png",
                height: size.height * 0.2125, // 170/800
                width: size.width * 0.541, // 195/360
                fit: BoxFit.contain,
              ),
              Image.asset(
                "assets/monitorvechiclecard.png",
                height: size.height * 0.2125,
                width: size.width * 0.541,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}