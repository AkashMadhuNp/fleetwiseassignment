import 'package:fleetwise/screens/add_vechicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constant/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> _fetchUserName() async {
    final storage = FlutterSecureStorage();
    final name = await storage.read(key: 'user_name');
    print("Fetched name from storage in HomePage: $name"); 
    return name ?? "Human";   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 700,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/bgphn.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 50,
                  left: 50,
                  child: LogoName(),
                ),
                Positioned(
                  top: 130,
                  left: 90,
                  child: FutureBuilder<String>(
                    future: _fetchUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Namaste 🙏🏻,",
                              style: GoogleFonts.inter(
                                color: AppColors.greyText,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Loading...",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        );
                      }
                      if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Namaste 🙏🏻,",
                              style: GoogleFonts.inter(
                                color: AppColors.greyText,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Raman Ji",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Namaste 🙏🏻,",
                            style: GoogleFonts.inter(
                              color: AppColors.greyText,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            snapshot.data!,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 620,
                  right: 20,
                  left: 20,
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          context,
                          icon: Icons.add,
                          text: "Add First Vehicle",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => AddVehicleScreen()));
                          },
                        ),
                        SizedBox(width: 6),
                        _buildActionButton(
                          context,
                          icon: Icons.add,
                          text: "Add First Driver",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Text(
                "What you get on FleetWise:",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueText,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/Earningtracking.png",
                    height:  170,
                    width: 195,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    "assets/monitorvechiclecard.png",
                    height: 170,
                    width: 195,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    {required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: AppColors.primary),
      label: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        minimumSize: Size(182, 54),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class LogoName extends StatelessWidget {
  const LogoName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Fleet",
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0,
                  color: AppColors.white,
                ),
              ),
              TextSpan(
                text: "Wise",
                style: GoogleFonts.inter(
                  fontSize: 26,
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