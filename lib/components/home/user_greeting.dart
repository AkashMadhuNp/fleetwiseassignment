import 'package:fleetwise/constant/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class UserGreeting extends StatelessWidget {
  final String text;

  const UserGreeting({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Namaste 🙏🏻,",
          style: GoogleFonts.inter(
            color: AppColors.greyText,
            fontSize: size.width * 0.05, 
          ),
        ),
        Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            fontSize: size.width * 0.066, 
          ),
        ),
      ],
    );
  }
}
