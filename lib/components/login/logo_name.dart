import 'package:fleetwise/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoName extends StatelessWidget {
  const LogoName({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/logo.gif",
            height: 58,
            width: 58,
          ),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Fleet",
                  style: GoogleFonts.inter(
                    fontSize: 48,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0,
                    color: AppColors.primary,
                  ),
                ),
                TextSpan(
                  text: "Wise",
                  style: GoogleFonts.inter(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
