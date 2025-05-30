import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final double scaleFactor;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double tabWidth = 122 * scaleFactor;
    final double tabHeight = 41 * scaleFactor;
    final double tabPadding = 12 * scaleFactor;
    final double fontSize = 14 * scaleFactor;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, // 4% of screen width
        vertical: 16 * scaleFactor,
      ),
      child: FractionallySizedBox(
        widthFactor: 1.0, // Full width of parent
        child: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          labelStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            height: 1.0,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
            height: 1.0,
          ),
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100 * scaleFactor),
          ),
          labelPadding: EdgeInsets.symmetric(horizontal: tabPadding),
          dividerColor: Colors.transparent,
          tabs: [
            Tab(
              child: Container(
                width: tabWidth,
                height: tabHeight,
                alignment: Alignment.center,
                child: Text(
                  "Yesterday",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Tab(
              child: Container(
                width: tabWidth,
                height: tabHeight,
                alignment: Alignment.center,
                child: Text(
                  "Today",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Tab(
              child: Container(
                width: tabWidth,
                height: tabHeight,
                alignment: Alignment.center,
                child: Text(
                  "Monthly",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}