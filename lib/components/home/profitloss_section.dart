import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfitLossSection extends StatelessWidget {
  final double scaleFactor;
  final String profitLoss;
  final String date;
  final String predicted;

  const ProfitLossSection({
    super.key,
    required this.scaleFactor,
    required this.profitLoss,
    required this.date,
    required this.predicted,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9, // Constrain width to 90% of screen
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profit/Loss",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16 * scaleFactor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: 12 * scaleFactor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  profitLoss,
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 18 * scaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  predicted.isEmpty ? "" : "predicted: $predicted",
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: 12 * scaleFactor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}