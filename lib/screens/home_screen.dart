import 'package:fleetwise/screens/home_paage.dart';
import 'package:fleetwise/screens/loss_profit_details.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _homePageIndex = 0; // Track the current page within the "Home" tab

  // Define pages for the BottomNavigationBar
  static const List<Widget> _tabPages = <Widget>[
    HomeTab(), // Custom widget for the slider within "Home"
    VehiclesPage(),
    DriversPage(),
    AccountPage(),
  ];

  // Pages for the Home tab slider
  static final List<Widget> _homePages = <Widget>[
    HomePage(),
    LossProfitDetails(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Reset _homePageIndex when switching away from Home tab
      if (index != 0) _homePageIndex = 0;
    });
  }

  void _onPageChanged(int index) {
    if (_selectedIndex == 0) {
      setState(() {
        _homePageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Drivers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.greyText,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Custom widget for the Home tab with PageView
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          HomePage(),
          LossProfitDetails(),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: _currentPage == index ? AppColors.primary : AppColors.greyText,
            ),
          );
        }),
      ),
    );
  }
}

// Placeholder pages remain unchanged
class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vehicles")),
      body: const Center(child: Text("Vehicles Page")),
    );
  }
}

class DriversPage extends StatelessWidget {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drivers")),
      body: const Center(child: Text("Drivers Page")),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account")),
      body: const Center(child: Text("Account Page")),
    );
  }
}