import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For Inter font



class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; 
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _positionAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    final double beginPosition = _calculateIndicatorPosition(_selectedIndex);
    final double endPosition = _calculateIndicatorPosition(index);
    
    _positionAnimation = Tween<double>(
      begin: beginPosition,
      end: endPosition,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _animationController.reset();
    _animationController.forward();
    
    setState(() {
      _selectedIndex = index;
    });
  }

  double _calculateIndicatorPosition(int index) {
    const navItemCount = 4;
    const separatorCount = 3;
    const separatorWidth = 1.0;
    
    final totalSeparatorWidth = separatorWidth * separatorCount;
    final availableWidth = MediaQuery.of(context).size.width - totalSeparatorWidth;
    final navItemWidth = availableWidth / navItemCount;
    
    double position = navItemWidth * index;
    if (index > 0) {
      position += separatorWidth * index;
    }
    
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102, 
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE), 
        border: Border(
          top: BorderSide(color: Color(0xFFFFFFFF), width: 2), 
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildSeparator(),
              _buildNavItem(Icons.local_shipping, 'Vehicles', 1),
              _buildSeparator(),
              _buildNavItem(Icons.directions_car, 'Drivers', 2),
              _buildSeparator(),
              _buildNavItem(Icons.person, 'Account', 3),
            ],
          ),
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return Positioned(
                top: 0,
                left: _positionAnimation.value,
                child: _buildIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    const navItemCount = 4;
    const separatorCount = 3;
    const separatorWidth = 1.0;
    final availableWidth = MediaQuery.of(context).size.width - (separatorWidth * separatorCount);
    final indicatorWidth = availableWidth / navItemCount;
    
    return Container(
      width: indicatorWidth,
      height: 4,
      child: Stack(
        children: [
          Container(
            color: Colors.black, 
          ),
          Positioned(
            right: 0,
            child: CustomPaint(
              size: const Size(10, 4),
              painter: ArrowPainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2, left: 3), 
                child: Icon(
                  icon,
                  color: isSelected ? Colors.black : const Color(0xFF9B9B9B),
                  size: 20, 
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 35, 
                height: 15, 
                child: Center(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.black : const Color(0xFF9B9B9B),
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      height: 1.0, 
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 1,
      height: 102, 
      color: const Color(0xFFE0E0E0), 
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00C853) 
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}