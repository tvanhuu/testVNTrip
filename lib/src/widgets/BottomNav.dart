import 'package:flutter/material.dart';
import 'package:testExample1/src/helpers/ColorsApp.dart';
import 'package:testExample1/src/helpers/index.dart';
import 'package:testExample1/src/navigator/Main.dart';
import 'package:testExample1/src/extensions/Iterable.dart';

class BottomNav extends StatefulWidget {
  final int selectTabIndex;
  final List<NavigationBarItem> tabs;
  final Function onPessTab;

  const BottomNav({Key key, this.selectTabIndex, this.tabs, this.onPessTab})
      : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            color: Colors.white.withOpacity(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.tabs.mapIndexed(
                (e, i) {
                  Color c = i == widget.selectTabIndex
                      ? HexColor("#F04F5F")
                      : HexColor("#C5CEE0");

                  return InkWell(
                    onTap: () => widget.onPessTab(i),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: i == 2 ? buildMap() : buildItemBar(e, c),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemBar(NavigationBarItem e, Color c) {
    return Column(
      children: [
        Icon(e.icon, color: c),
        Text(
          e.label,
          style: TextStyle(color: c),
        ),
      ],
    );
  }

  Widget buildMap() {
    return Container(
      width: getWidth(context) * 0.18,
      height: getWidth(context) * 0.18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            HexColor("#F79441"),
            HexColor("#F25F58"),
          ],
          stops: [0.4, 1.0],
        ),
        image: DecorationImage(
          image: AssetImage(
            "assets/quick.png",
          ),
          fit: BoxFit.none,
        ),
        border: Border.all(
          color: HexColor("#F79441"),
          width: 1.5,
        ),
      ),
    );
  }
}
