import 'package:flutter/material.dart';
import 'package:testExample1/src/screens/__TEM__/TEM.dart';
import 'package:testExample1/src/screens/index.dart';
import 'package:testExample1/src/widgets/BottomNav.dart';

class NavigationBarItem {
  IconData icon;
  String label;

  NavigationBarItem({IconData icon, String label}) {
    this.icon = icon;
    this.label = label;
  }
}

class Main extends StatefulWidget {
  final List<Widget> _screen = [
    Home(),
    TEM(),
    MapHotel(),
    TEM(),
    TEM(),
  ];

  final List<NavigationBarItem> _tabs = [
    NavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    NavigationBarItem(
      icon: Icons.description,
      label: 'Đơn hàng',
    ),
    NavigationBarItem(
      icon: Icons.no_encryption,
      label: '',
    ),
    NavigationBarItem(
      icon: Icons.local_offer,
      label: 'Ưu đãi',
    ),
    NavigationBarItem(
      icon: Icons.account_circle,
      label: 'Tài khoản',
    ),
  ];

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectTabIndex = 0;

  List<Widget> get screens => widget._screen;
  List<NavigationBarItem> get tabs => widget._tabs;

  void onPessTab(int index) {
    setState(() {
      _selectTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectTabIndex,
        children: [
          for (final screen in screens) screen,
        ],
      ),
      bottomNavigationBar: BottomNav(
        selectTabIndex: _selectTabIndex,
        tabs: tabs,
        onPessTab: onPessTab,
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(0, size.height * 0.50);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.50);
    path.lineTo(size.width * 0.61, size.height * 0.50);
    path.quadraticBezierTo(
        size.width * 0.61, size.height * 0.01, size.width * 0.50, 0);
    path.quadraticBezierTo(size.width * 0.39, size.height * 0.02,
        size.width * 0.39, size.height * 0.50);
    path.lineTo(size.width * -0.01, size.height * 0.50);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
