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
    final double contentWidth = 398 * scaleFactor;
    final double contentHeight = 69 * scaleFactor;
    final double contentPadding = 16 * scaleFactor;
    final double contentBorderRadius = 16 * scaleFactor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Profit/Loss",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16 * scaleFactor,
              ),
            ),

             Text(
              date,
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 12 * scaleFactor,
              ),
            ),



          ],
        ),
        Column(
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
            ),
           
            Text(
              predicted.isEmpty ? "" : "predicted: $predicted",
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 12 * scaleFactor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}