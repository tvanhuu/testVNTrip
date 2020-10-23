import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testExample1/src/helpers/ColorsApp.dart';
import 'package:testExample1/src/helpers/Dimension.dart';
import 'package:testExample1/src/helpers/Token.dart';
import 'package:testExample1/src/screens/Home/widget/index.dart';
import 'package:testExample1/src/singleton/SingletonPosition.dart';

import '../../helpers/index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    print(SingletonPosition.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width(context, 16)),
          width: double.infinity,
          child: Column(
            children: [
              buildHeader(),
              SizedBox(height: width(context, 12)),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    buildBaner(),
                    buildShortcut(),
                    buildSticky(),
                    buildTopHotel(),
                    buildSuggestionHotel(),
                    FlatButton(
                      onPressed: () => deleteToken(),
                      child: Text("Xem Thêm"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSuggestionHotel() {
    return ListHotelSuggestion();
  }

  Widget buildTopHotel() {
    return ListTopHotel();
  }

  Widget buildSticky() {
    return Discount();
  }

  Widget buildShortcut() {
    return Shortcut();
  }

  Widget buildBaner() {
    return BannerApp();
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/quick.png",
          color: Colors.red,
          width: getWidth(context) * 0.1,
          height: getWidth(context) * 0.1,
        ),
        SizedBox(width: getWidth(context) * 0.03),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: HexColor("#F7F9FC"),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              onChanged: (String text) => {},
              decoration: InputDecoration(
                hintText: 'Tìm kiếm khách sạn...',
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
