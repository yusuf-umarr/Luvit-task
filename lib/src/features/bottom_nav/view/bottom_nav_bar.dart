import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luvit/src/core/constant/app_color.dart';
import 'package:luvit/src/features/home/view/home_page.dart';
import 'package:luvit/src/provider/provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomePage(),
    Center(child: Text('Screen 2')),
    Center(child: Text('Screen 3')),
    Center(child: Text('Screen 4')),
    Center(child: Text('Screen 5')),
  ];

  List iconList = [
    {"id": 0, "name": "Home", "icon": "assets/homeIcon1.svg"},
    {"id": 1, "name": "Home", "icon": "assets/locationIcin1.svg"},
    {"id": 2, "name": "Home", "icon": "assets/homeIcon1.svg"},
    {"id": 3, "name": "Home", "icon": "assets/messageIcon1.svg"},
    {"id": 4, "name": "Home", "icon": "assets/profileicon1.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          border: Border(
            right: BorderSide(
              color: Colors.black.withOpacity(0.3),
              width: 1,
            ),
            top: BorderSide(
              color: Colors.black.withOpacity(0.3),
              width: 1,
            ),
            left: BorderSide(
              color: Colors.black.withOpacity(0.3),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: CustomPaint(
            painter: BottomNavigationBarPainter(color: Colors.black),
            child: SizedBox(
              height: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: iconList.map((e) {
                    if (e['id'] == 2) {
                      return const SizedBox();
                    }
                    return IconButton(
                      icon: SvgPicture.asset(
                        e['icon'],
                        colorFilter: ColorFilter.mode(
                            _selectedIndex == e['id']
                                ? AppColors.primaryColor
                                : AppColors.greyColor,
                            BlendMode.srcIn),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = e['id'];
                        });
                        context.read<SwipeProvider>().resetState();
                      },
                    );
                  }).toList()),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: SvgPicture.asset(
                "assets/centerBgIcon.svg",
              ),
            )),
      ),
    );
  }
}

class BottomNavigationBarPainter extends CustomPainter {
  final Color color;

  BottomNavigationBarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 20)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..lineTo(size.width - 20, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
