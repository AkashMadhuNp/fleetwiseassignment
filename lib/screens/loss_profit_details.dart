import 'package:dio/dio.dart';
import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/BLoC/bloc/auth_state.dart';
import 'package:fleetwise/components/home/custom_tab_bar.dart';
import 'package:fleetwise/components/home/info_card.dart';
import 'package:fleetwise/components/home/profitloss_section.dart';
import 'package:fleetwise/constant/colors.dart';
import 'package:fleetwise/models/pnl_model.dart';
import 'package:fleetwise/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
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
  bool _isOffline = false;

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
    final storage = const FlutterSecureStorage();
    final name = await storage.read(key: 'user_name');
    print("Fetched name from storage in LossProfitDetails: $name");
    return name ?? "Human";
  }

  void _refreshData() {
    setState(() {
      _todayPnL = _apiService.getTodayPnL();
      _yesterdayPnL = _apiService.getYesterdayPnL();
      _monthlyPnL = _apiService.getMonthlyPnL();
    });
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

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated || state is AuthError) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          onRefresh: () async {
            _refreshData();
          },
          child: Stack(
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
                  if (_isOffline)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.all(8 * scaleFactor),
                      child: const Center(
                        child: Text(
                          "You are offline, data may be outdated",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
        ),
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
          if (snapshot.error.toString().contains("Session expired")) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/login');
            });
            return const SizedBox();
          }
          setState(() {
            _isOffline = snapshot.error is DioException &&
                (snapshot.error as DioException).type ==
                    DioExceptionType.connectionTimeout;
          });
          return Center(child: Text("Error loading data: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return _buildTabContent(
            scaleFactor: scaleFactor,
            profitLoss: formatCurrency("${data.header.profitLoss}"),
            date: "Today",
            predicted: formatCurrency("0"),
            earnings: formatCurrency("${data.header.earning}"),
            earningsPredicted: formatCurrency("${data.header.earning}"),
            variableCost: formatCurrency("${data.header.variableCost}"),
            variableCostPredicted: formatCurrency("${data.header.variableCost}"),
            trips: data.header.tripsCompleted.toString(),
            vehicles:
                "${data.header.vehiclesOnRoad}/${data.vehicles.length}",
            distance: "${data.header.totalDistance} km",
            vehicleData: data.vehicles,
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
          if (snapshot.error.toString().contains("Session expired")) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/login');
            });
            return const SizedBox();
          }
          setState(() {
            _isOffline = snapshot.error is DioException &&
                (snapshot.error as DioException).type ==
                    DioExceptionType.connectionTimeout;
          });
          return Center(child: Text("Error loading data: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return _buildTabContent(
            scaleFactor: scaleFactor,
            profitLoss: formatCurrency("${data.header.profitLoss}"),
            date: "Yesterday",
            predicted: formatCurrency("0"),
            earnings: formatCurrency("${data.header.earning}"),
            earningsPredicted: formatCurrency("${data.header.earning}"),
            variableCost: formatCurrency("${data.header.variableCost}"),
            variableCostPredicted: formatCurrency("${data.header.variableCost}"),
            trips: data.header.tripsCompleted.toString(),
            vehicles: "${data.header.vehiclesOnRoad}/${data.vehicles.length}",
            distance: "${data.header.totalDistance} km",
            vehicleData: data.vehicles,
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
          if (snapshot.error.toString().contains("Session expired")) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/login');
            });
            return const SizedBox();
          }
          setState(() {
            _isOffline = snapshot.error is DioException &&
                (snapshot.error as DioException).type ==
                    DioExceptionType.connectionTimeout;
          });
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
                    subtitle:
                        "Distance driven by ${data.vehicles.length} vehicles",
                    value: "${data.header.totalDistance} km",
                  ),
                  SizedBox(height: 16 * scaleFactor),
                  _buildVehiclesOverview(data.vehicles, scaleFactor),
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

  Widget _buildTabContent({
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
    required List<dynamic> vehicleData,
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
              subtitle: date == "Today"
                  ? "Your approx earning till now"
                  : "Total revenue generated",
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
              subtitle: date == "Today"
                  ? "Stay updated on progress"
                  : "Successful trips finished",
              value: trips,
            ),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon4.png',
              imageBackgroundColor: Colors.purple,
              title: "Vehicles on the road",
              subtitle: date == "Today"
                  ? "Active vehicles right now"
                  : "Active fleet count",
              value: vehicles,
            ),
            InfoCard(
              scaleFactor: scaleFactor,
              imagePath: 'assets/Icon5.png',
              imageBackgroundColor: Colors.orange,
              title: "Total distance travelled",
              subtitle: date == "Today"
                  ? "Total distance travelled till now!"
                  : "Kilometers covered by the fleet",
              value: distance,
            ),
            SizedBox(height: 22 * scaleFactor),
            _buildVehiclesOverview(vehicleData, scaleFactor),
            SizedBox(height: 16 * scaleFactor),
          ],
        ),
      ),
    );
  }

  Widget _buildVehiclesOverview(List<dynamic> vehicles, double scaleFactor) {
  return Container(
    padding: EdgeInsets.all(8 * scaleFactor),
    color: Colors.grey[200],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              "assets/ambulance.png",
              height: 24 * scaleFactor,
              width: 24 * scaleFactor,
            ),
            SizedBox(width: 8 * scaleFactor),
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
        vehicles.isEmpty
            ? Padding(
                padding: EdgeInsets.all(8 * scaleFactor),
                child: Text(
                  "No vehicles available",
                  style: GoogleFonts.inter(fontSize: 16 * scaleFactor),
                ),
              )
            : Column(
                children: vehicles.map((vehicle) {
                  final v = vehicle as Vehicle;
                  
                  Color statusColor;
                  String statusText = v.vehicleStatus.toUpperCase();
                  switch (v.vehicleStatus.toLowerCase()) {
                    case 'running':
                      statusColor = Colors.green;
                      break;
                    case 'idle':
                      statusColor = Colors.orange;
                      break;
                    case 'inactive':
                      statusColor = Colors.grey;
                      break;
                    default:
                      statusColor = Colors.grey;
                  }

                 
                  Color profitLossColor = v.profitLoss >= 0 ? Colors.green : Colors.red;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8 * scaleFactor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleFactor),
                    ),
                    elevation: 0, 
                    child: Container(
                      width: 398 * scaleFactor,
                      height: 266 * scaleFactor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16 * scaleFactor),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0F122E46),
                            offset: Offset(0, 6 * scaleFactor),
                            blurRadius: 16 * scaleFactor,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * scaleFactor,
                          vertical: 16 * scaleFactor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      v.vehicleNumber,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16 * scaleFactor,
                                        color: AppColors.blueText,
                                      ),
                                    ),
                                    SizedBox(width: 8 * scaleFactor),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8 * scaleFactor,
                                        vertical: 4 * scaleFactor,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(8 * scaleFactor),
                                      ),
                                      child: Text(
                                        statusText,
                                        style: GoogleFonts.inter(
                                          fontSize: 12 * scaleFactor,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: v.profitLoss >= 0 ? Colors.green.shade100 : Colors.red.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      formatCurrency(v.profitLoss.toString()),
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16 * scaleFactor,
                                        color: profitLossColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8 * scaleFactor),
                            Row(
                              children: [
                                SvgPicture.asset("assets/steering.svg",height: 20,width: 20,),
                                // Icon(Icons.person_outline,
                                //     size: 16 * scaleFactor, color: Colors.grey),
                                SizedBox(width: 4 * scaleFactor),
                                Text(
                                  v.driverName ?? "No Driver Assigned",
                                  style: GoogleFonts.inter(
                                    fontSize: 14 * scaleFactor,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(width: 170*scaleFactor,),
                                Text("Profit/Loss")
                              ],
                            ),
                            SizedBox(height: 16 * scaleFactor),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20 * scaleFactor,
                                        height: 20 * scaleFactor,
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                      SizedBox(width: 8 * scaleFactor),
                                      Text(
                                        "Cost",
                                        style: GoogleFonts.inter(
                                          fontSize: 14 * scaleFactor,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  formatCurrency(v.costing.toString()),
                                  style: GoogleFonts.inter(
                                    fontSize: 14 * scaleFactor,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4 * scaleFactor),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20 * scaleFactor,
                                        height: 20 * scaleFactor,
                                        color: v.earning >= v.costing
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      SizedBox(width: 8 * scaleFactor),
                                      Text(
                                        "Earnings",
                                        style: GoogleFonts.inter(
                                          fontSize: 14 * scaleFactor,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  formatCurrency(v.earning.toString()),
                                  style: GoogleFonts.inter(
                                    fontSize: 14 * scaleFactor,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            // SOS Alert (optional, add logic based on your data)
                            if (v.vehicleStatus.toLowerCase() == 'idle')
                              Container(
                                margin: EdgeInsets.only(top: 16 * scaleFactor),
                                padding: EdgeInsets.all(8 * scaleFactor),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[50],
                                  borderRadius:
                                      BorderRadius.circular(8 * scaleFactor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.warning,
                                        size: 16 * scaleFactor, color: Colors.red),
                                    SizedBox(width: 8 * scaleFactor),
                                    Text(
                                      "SOS call made at 12:53 AM by driver",
                                      style: GoogleFonts.inter(
                                        fontSize: 12 * scaleFactor,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios,
                                        size: 12 * scaleFactor,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ],
    ),
  );
}
}