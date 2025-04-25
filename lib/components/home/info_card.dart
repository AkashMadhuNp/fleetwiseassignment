import 'package:fleetwise/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final double scaleFactor;
  final String imagePath; // Changed from IconData to String for asset path
  final Color imageBackgroundColor; // Renamed from iconColor for clarity
  final String title;
  final String subtitle;
  final String? value;
  final String? predicted;

  const InfoCard({
    super.key,
    required this.scaleFactor,
    required this.imagePath, // Updated parameter name
    required this.imageBackgroundColor, // Updated parameter name
    required this.title,
    required this.subtitle,
    this.value,
    this.predicted,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
        minHeight: 69 * scaleFactor,
        maxWidth: screenWidth - (32 * scaleFactor), // accounting for padding
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.background,
        margin: EdgeInsets.symmetric(vertical: 8 * scaleFactor),
        child: Padding(
          padding: EdgeInsets.all(16 * scaleFactor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 38 * scaleFactor, // Set height to 38, scaled
                width: 38 * scaleFactor, // Set width to 38, scaled
              ),
              SizedBox(width: 16 * scaleFactor),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 14 * scaleFactor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4 * scaleFactor),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12 * scaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
              if (value != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value!,
                      style: GoogleFonts.inter(
                        color: AppColors.blueText,
                        fontSize: 16 * scaleFactor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (predicted != null)
                      Text(
                        "predicted: $predicted",
                        style: GoogleFonts.inter(
                          color: AppColors.greyText,
                          fontWeight: FontWeight.w400,
                          fontSize: 12 * scaleFactor,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}