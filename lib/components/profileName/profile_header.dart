import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What shall we call you?",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueText,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: screenWidth * 0.02), 
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(
                    color: AppColors.greyText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    const TextSpan(text: "Enter full name as on your"),
                    TextSpan(
                      text: " Aadhar Card",
                      style: GoogleFonts.inter(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
        
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02), 
          child: Image.asset(
            "assets/profile_image.png",
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}