import 'package:fleetwise/constant/colors.dart';
import 'package:fleetwise/screens/add_vechicle_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchUserName() async {
      final storage = FlutterSecureStorage();
      final name = await storage.read(key: 'user_name');
      print("Fetched name from storage in HomePage: $name");
      return name ?? "Human";
    }

    const double designWidth = 414.0;
    final double scaleFactor = MediaQuery.of(context).size.width / designWidth;
    final double constrainedScaleFactor = scaleFactor.clamp(0.8, 1.2);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height * 0.83).clamp(600, 800) * constrainedScaleFactor,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF3F5BD9), Colors.black],
                        stops: [0.0, 0.3],
                      ),
                    ),
                  ),
      
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/crosslines.png",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        print("Image error: $error");
                        return Container(color: Colors.black);
                      },
                    ),
                  ),
      
                  Positioned(
                    top: 40 * constrainedScaleFactor,
                    left: 50 * constrainedScaleFactor,
                    right: 50 * constrainedScaleFactor,
                    child: const LogoName(),
                  ),
      
                  Positioned(
                    top: 90 * constrainedScaleFactor,
                    left: 16 * constrainedScaleFactor,
                    right: 16 * constrainedScaleFactor,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/whiteIcon.png",
                          width: 60 * constrainedScaleFactor,
                          height: 60 * constrainedScaleFactor,
                        ),
                        SizedBox(width: 10 * constrainedScaleFactor),
                        FutureBuilder<String>(
                          future: _fetchUserName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text(
                                "Loading...",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: 24 * constrainedScaleFactor,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                "Error",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: 24 * constrainedScaleFactor,
                                ),
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Namaste 🙏🏻,",
                                    style: GoogleFonts.inter(
                                      color: AppColors.greyText,
                                      fontSize: 18 * constrainedScaleFactor,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data ?? "Human",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                      fontSize: 24 * constrainedScaleFactor,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
      
                 
                  Positioned(
                    top: 200 * constrainedScaleFactor,
                    left: 20 * constrainedScaleFactor,
                    right: 20 * constrainedScaleFactor,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0 * constrainedScaleFactor),
                          child: Container(
                            height: 398 * constrainedScaleFactor,
                            width: 398 * constrainedScaleFactor,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0x00101010),
                                  Color(0xCC101010),
                                  Color(0xFF101010),
                                ],
                                stops: [0.5515, 0.7506, 0.872],
                              ),
                              borderRadius: BorderRadius.circular(16 * constrainedScaleFactor),
                              border: Border.all(
                                color: AppColors.greyText,
                                width: 2 * constrainedScaleFactor,
                              ),
                            ),
                            child: Image.asset(
                              "assets/iPhone.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20 * constrainedScaleFactor,
                          left: 50 * constrainedScaleFactor,
                          right: 50 * constrainedScaleFactor,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Track Your Profit & Loss in",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16 * constrainedScaleFactor,
                                    color: AppColors.white,
                                  ),
                                ),
                                Text(
                                  "Real-Time!",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20 * constrainedScaleFactor,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20 * constrainedScaleFactor,
                          left: 40 * constrainedScaleFactor,
                          right: 40 * constrainedScaleFactor,
                          child: Container(
                            height: 70 * constrainedScaleFactor,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0x00101010),
                                  Color(0xCC101010),
                                  Colors.black,
                                  Colors.black,
                                  Colors.black,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0 * constrainedScaleFactor,
                                  vertical: 8.0 * constrainedScaleFactor,
                                ),
                                child: Text(
                                  "See your profit and loss grow\nas your vehicles runs!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16 * constrainedScaleFactor,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  // Action buttons
                  Positioned(
                    bottom: 40 * constrainedScaleFactor,
                    left: 20 * constrainedScaleFactor,
                    right: 20 * constrainedScaleFactor,
                    child: Container(
                      height: 70 * constrainedScaleFactor,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildActionButton(
                            context,
                            icon: Icons.add,
                            text: "Add First Vehicle",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => AddVehicleScreen()),
                              );
                            },
                            scaleFactor: constrainedScaleFactor,
                          ),
                          SizedBox(width: 6 * constrainedScaleFactor),
                          _buildActionButton(
                            context,
                            icon: Icons.add,
                            text: "Add First Driver",
                            onPressed: () {},
                            scaleFactor: constrainedScaleFactor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      
            Padding(
              padding: EdgeInsets.only(
                left: 16.0 * constrainedScaleFactor,
                top: 16 * constrainedScaleFactor,
              ),
              child: Text(
                "What you get on FleetWise:",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueText,
                  fontSize: 18 * constrainedScaleFactor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8 * constrainedScaleFactor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/Earningtracking.png",
                    height: 170 * constrainedScaleFactor,
                    width: 195 * constrainedScaleFactor,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      print("Image error: $error");
                      return Container(
                        height: 170 * constrainedScaleFactor,
                        width: 195 * constrainedScaleFactor,
                        color: Colors.grey,
                        child: const Center(child: Text("Image failed to load")),
                      );
                    },
                  ),
                  SizedBox(width: 8 * constrainedScaleFactor),
                  Image.asset(
                    "assets/monitorvechiclecard.png",
                    height: 170 * constrainedScaleFactor,
                    width: 195 * constrainedScaleFactor,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      print("Image error: $error");
                      return Container(
                        height: 170 * constrainedScaleFactor,
                        width: 195 * constrainedScaleFactor,
                        color: Colors.grey,
                        child: const Center(child: Text("Image failed to load")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildActionButton(
  BuildContext context, {
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
  required double scaleFactor,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, size: 20 * scaleFactor, color: AppColors.primary),
    label: Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14 * scaleFactor,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.white,
      minimumSize: Size(182 * scaleFactor, 54 * scaleFactor),
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scaleFactor,
        vertical: 12 * scaleFactor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16 * scaleFactor),
      ),
    ),
  );
}

class LogoName extends StatelessWidget {
  const LogoName({super.key});

  @override
  Widget build(BuildContext context) {
    // Scale logo text for consistency
    const double designWidth = 414.0;
    final double scaleFactor = MediaQuery.of(context).size.width / designWidth;
    final double constrainedScaleFactor = scaleFactor.clamp(0.8, 1.2);

    return Container(
      height: 30 * constrainedScaleFactor,
      width: 80 * constrainedScaleFactor,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Fleet",
                style: GoogleFonts.inter(
                  fontSize: 26 * constrainedScaleFactor,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0,
                  color: AppColors.white,
                ),
              ),
              TextSpan(
                text: "Wise",
                style: GoogleFonts.inter(
                  fontSize: 26 * constrainedScaleFactor,
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