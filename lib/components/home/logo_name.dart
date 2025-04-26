import 'package:fleetwise/constant/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoName extends StatelessWidget {
  const LogoName({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.0375, // 30/800
      width: size.width * 0.222, // 80/360
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Fleet",
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.072, // 26/360
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0,
                  color: AppColors.white,
                ),
              ),
              TextSpan(
                text: "Wise",
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.072,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}