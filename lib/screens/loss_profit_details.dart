import 'package:fleetwise/components/home/custom_tab_bar.dart';
import 'package:fleetwise/components/home/info_card.dart';
import 'package:fleetwise/components/home/profitloss_section.dart';
import 'package:fleetwise/constant/colors.dart';
import 'package:fleetwise/models/pnl_model.dart';
import 'package:fleetwise/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LossProfitDetails extends StatefulWidget {
  const LossProfitDetails({super.key});

  @override
  State<LossProfitDetails> createState() => _LossProfitDetailsState();
}

class _LossProfitDetailsState extends State<LossProfitDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Color> _gradientColors = [
    const Color(0xFF94716B),
    const Color(0xFF101010),
  ];
  final ApiService _apiService = ApiService();
  late Future<PnLData> _todayPnL;
  late Future<PnLData> _yesterdayPnL;
  late Future<PnLData> _monthlyPnL;

  String formatCurrency(String amount) {
    if (amount.startsWith('₹')) {
      amount = amount.substring(1);
    }
    try {
      double value = double.parse(amount);
      return '₹${value.toInt()}';
    } catch (e) {
      return '₹$amount';
    }
  }

  Future<String> _fetchUserName() async {
    final storage = FlutterSecureStorage();
    final name = await storage.read(key: 'user_name');
    print("Fetched name from storage in HomePage: $name");
    return name ?? "Human";
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          _gradientColors = [
            const Color(0xFF94716B),
            const Color(0xFF101010),
          ];
        } else if (_tabController.index == 1) {
          _gradientColors = [
            const Color(0xFF5A928F),
            const Color(0xFF101010),
          ];
        } else {
          _gradientColors = [
            const Color(0xFF769461),
            const Color(0xFF101010),
          ];
        }
      });
    });

    _todayPnL = _apiService.getTodayPnL();
    _yesterdayPnL = _apiService.getYesterdayPnL();
    _monthlyPnL = _apiService.getMonthlyPnL();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double designWidth = 414.0;
    final double scaleFactor = MediaQuery.of(context).size.width / designWidth;
    final double imageHeight = 200 * scaleFactor;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.83,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _gradientColors,
                stops: const [0.0, 0.12],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/crosslines.png",
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.black);
              },
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 70 * scaleFactor,
                  left: 16 * scaleFactor,
                  right: 16 * scaleFactor,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/whiteIcon.png",
                      width: 40 * scaleFactor,
                      height: 40 * scaleFactor,
                    ),
                    SizedBox(width: 10 * scaleFactor),
                    FutureBuilder<String>(
                      future: _fetchUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text(
                            "Loading...",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontSize: 24 * scaleFactor,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            "Error",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                              fontSize: 24 * scaleFactor,
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
                                  fontSize: 18 * scaleFactor,
                                ),
                              ),
                              Text(
                                snapshot.data ?? "Human",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: 24 * scaleFactor,
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
              CustomTabBar(
                tabController: _tabController,
                scaleFactor: scaleFactor,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTodayTabContent(scaleFactor),
                    _buildYesterdayTabContent(scaleFactor),
                    _buildMonthlyTabContent(scaleFactor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTabContent(double scaleFactor) {
    return FutureBuilder<PnLData>(
      future: _todayPnL,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading data: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return _buildYestTabContent(
            scaleFactor: scaleFactor,
            profitLoss: formatCurrency("${data.header.profitLoss}"),
            date: "Today",
            predicted: formatCurrency("0"),
            earnings: formatCurrency("${data.header.earning}"),
            earningsPredicted: formatCurrency("${data.header.earning}"),
            variableCost: formatCurrency("${data.header.variableCost}"),
            variableCostPredicted: formatCurrency("${data.header.variableCost}"),
            trips: data.header.tripsCompleted.toString(),
            vehicles: "${data.header.vehiclesOnRoad}/${data.vehicles.length}",
            distance: "${data.header.totalDistance} km",
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildYesterdayTabContent(double scaleFactor) {
    return FutureBuilder<PnLData>(
      future: _yesterdayPnL,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading data: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return _buildTodTabContent(
            scaleFactor: scaleFactor,
            profitLoss: formatCurrency("${data.header.profitLoss}"),
            date: "Yesterday",
            predicted: formatCurrency("0"),
            earnings: formatCurrency("${data.header.earning}"),
            earningsPredicted: formatCurrency("${data.header.earning}"),
            variableCost: formatCurrency("${data.header.variableCost}"),
            variableCostPredicted: formatCurrency("${data.header.variableCost}"),
            trips: data.header.tripsCompleted.toString(),
            vehicles: "${data.header.vehiclesOnRoad}",
            distance: "${data.header.totalDistance} km",
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildMonthlyTabContent(double scaleFactor) {
    return FutureBuilder<PnLData>(
      future: _monthlyPnL,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading data: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
              child: Column(
                children: [
                  ProfitLossSection(
                    scaleFactor: scaleFactor,
                    profitLoss: formatCurrency("${data.header.profitLoss}"),
                    date: "This Month",
                    predicted: formatCurrency("0"),
                  ),
                  SizedBox(height: 16 * scaleFactor),
                  InfoCard(
                    scaleFactor: scaleFactor,
                    imagePath: 'assets/Icon2.png',
                    imageBackgroundColor: Colors.green,
                    title: "Total Earning",
                    subtitle: "Your fleet has earned",
                    value: formatCurrency("${data.header.earning}"),
                  ),
                  InfoCard(
                    scaleFactor: scaleFactor,
                    imagePath: 'assets/Icon3.png',
                    imageBackgroundColor: Colors.red,
                    title: "Total Cost",
                    subtitle: "Track expenses to maximise profits",
                    value: formatCurrency("${data.header.costing}"),
                  ),
                  InfoCard(
                    scaleFactor: scaleFactor,
                    imagePath: 'assets/Icon4.png',
                    imageBackgroundColor: Colors.orange,
                    title: "Profit starting day",
                    subtitle: "Estimated break-even date",
                    value: "PREDICTING...",
                  ),
                  InfoCard(
                    scaleFactor: scaleFactor,
                    imagePath: 'assets/Icon5.png',
                    imageBackgroundColor: Colors.purple,
                    title: "Total distance driven",
                    subtitle: "Distance driven by ${data.vehicles.length} vehicles",
                    value: "${data.header.totalDistance} km",
                  ),
                  SizedBox(height: 16 * scaleFactor),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildYestTabContent({
  required double scaleFactor,
  required String profitLoss,
  required String date,
  required String predicted,
  required String earnings,
  required String earningsPredicted,
  required String variableCost,
  required String variableCostPredicted,
  required String trips,
  required String vehicles,
  required String distance,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
      child: Column(
        children: [
          ProfitLossSection(
            scaleFactor: scaleFactor,
            profitLoss: profitLoss,
            date: date,
            predicted: predicted,
          ),
          SizedBox(height: 16 * scaleFactor),
          InfoCard(
            scaleFactor: scaleFactor,
            imagePath: 'assets/Icon.png',
            imageBackgroundColor: Colors.green,
            title: "Earnings",
            subtitle: "Total revenue generated",
            value: earnings,
            predicted: earningsPredicted,
          ),
          InfoCard(
            scaleFactor: scaleFactor,
            imagePath: 'assets/Icon2.png',
            imageBackgroundColor: Colors.red,
            title: "Variable Cost",
            subtitle: "Expenses & maintenance",
            value: variableCost,
            predicted: variableCostPredicted,
          ),
          InfoCard(
            scaleFactor: scaleFactor,
            imagePath: 'assets/Icon3.png',
            imageBackgroundColor: Colors.blue,
            title: "No. of trips completed",
            subtitle: "Successful trips finished",
            value: trips,
          ),
          InfoCard(
            scaleFactor: scaleFactor,
            imagePath: 'assets/Icon4.png',
            imageBackgroundColor: Colors.purple,
            title: "Vehicles on the road",
            subtitle: "Active fleet count",
            value: vehicles,
          ),
          InfoCard(
            scaleFactor: scaleFactor,
            imagePath: 'assets/Icon5.png',
            imageBackgroundColor: Colors.orange,
            title: "Total distance travelled",
            subtitle: "Kilometers covered by the fleet",
            value: distance,
          ),
          // Add Vehicles Overview section here
          SizedBox(height: 22 * scaleFactor),
          Container(
            padding: EdgeInsets.all(8 * scaleFactor),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Image.asset("assets/ambulance.png",height: 24,width: 24,),
                    Text(
                      "Vehicles Overview",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 22 * scaleFactor,
                        color: AppColors.blueText,
                      ),
                    ),
                  ],
                ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: 2, // Adjust based on the number of vehicles
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       leading: Icon(Icons.directions_car, size: 24 * scaleFactor),
                //       title: Text(
                //         "UP-12 AK ${index == 0 ? '3248' : '3408'}",
                //         style: GoogleFonts.inter(fontSize: 16 * scaleFactor),
                //       ),
                //       subtitle: Text(
                //         "Profit/Loss: ₹${index == 0 ? '1,234' : '5,678'}",
                //         style: GoogleFonts.inter(fontSize: 14 * scaleFactor),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
          SizedBox(height: 16 * scaleFactor),
        ],
      ),
    ),
  );
}


  Widget _buildTodTabContent({
    required double scaleFactor,
    required String profitLoss,
    required String date,
    required String predicted,
    required String earnings,
    required String earningsPredicted,
    required String variableCost,
    required String variableCostPredicted,
    required String trips,
    required String vehicles,
    required String distance,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * scaleFactor),
        child: Column(
          children: [
            ProfitLossSection(
              scaleFactor: scaleFactor,
              profitLoss: profitLoss,
              date: date,
              predicted: predicted,
            ),
            SizedBox(height: 16 * scaleFactor),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon.png',
              imageBackgroundColor: Colors.green,
              title: "Earnings",
              subtitle: "your approx earning till now",
              value: earnings,
              predicted: earningsPredicted,
            ),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon2.png',
              imageBackgroundColor: Colors.red,
              title: "Variable Cost",
              subtitle: "Track expenses to maximise profits",
              value: variableCost,
              predicted: variableCostPredicted,
            ),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon3.png',
              imageBackgroundColor: Colors.blue,
              title: "No. of trips completed",
              subtitle: "Stay updated on progress",
              value: trips,
            ),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon4.png',
              imageBackgroundColor: Colors.purple,
              title: "Vehicles on the road",
              subtitle: "Active vehicles right now",
              value: vehicles,
            ),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon5.png',
              imageBackgroundColor: Colors.orange,
              title: "Total distance travelled",
              subtitle: "Total distance travelled till now!",
              value: distance,
            ),
            SizedBox(height: 16 * scaleFactor),
            SizedBox(height: 22 * scaleFactor),
          Container(
            padding: EdgeInsets.all(8 * scaleFactor),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Image.asset("assets/ambulance.png",height: 24,width: 24,),
                    Text(
                      "Vehicles Overview",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 22 * scaleFactor,
                        color: AppColors.blueText,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2, // Adjust based on the number of vehicles
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.directions_car, size: 24 * scaleFactor),
                      title: Text(
                        "UP-12 AK ${index == 0 ? '3248' : '3408'}",
                        style: GoogleFonts.inter(fontSize: 16 * scaleFactor),
                      ),
                      subtitle: Text(
                        "Profit/Loss: ₹${index == 0 ? '1,234' : '5,678'}",
                        style: GoogleFonts.inter(fontSize: 14 * scaleFactor),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16 * scaleFactor),
          ],
        ),
      ),
    );
  }
}