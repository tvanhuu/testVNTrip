import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/bloc/authentication/bloc.dart';
import 'package:testExample1/src/helpers/index.dart';
import 'package:testExample1/src/models/Hotel.dart';
import 'package:testExample1/src/navigator/Router.dart';
import 'package:testExample1/src/screens/Home/widget/ListHotelSuggestion/bloc/bloc.dart';

final Shader linearGradient = LinearGradient(
  colors: <Color>[HexColor("#F79441"), HexColor("#F25F58")],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);

class ListHotelSuggestion extends StatefulWidget {
  @override
  _ListHotelSuggestionState createState() => _ListHotelSuggestionState();
}

class _ListHotelSuggestionState extends State<ListHotelSuggestion>
    with AutomaticKeepAliveClientMixin<ListHotelSuggestion> {
  HotelSuggestionBloc hotelSuggestionBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    hotelSuggestionBloc = HotelSuggestionBloc();
    hotelSuggestionBloc.add(HotelSuggestionRequested());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      cubit: BlocProvider.of<AuthenticationBloc>(context),
      builder: (context, stateAuthen) {
        return BlocBuilder<HotelSuggestionBloc, HotelSuggestionState>(
          cubit: hotelSuggestionBloc,
          builder: (context, state) {
            if (state is HotelSuggestionSuccess) {
              return Padding(
                padding: EdgeInsets.only(top: height(context, 24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Khách sạn được đề xuất",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return HotelSuggestion(
                            hotel: state.hotelSuggestion[index],
                            isLogin: stateAuthen is AuthenticationAuthenticated,
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return SizedBox();
          },
        );
      },
    );
  }
}

class HotelSuggestion extends StatelessWidget {
  final Hotel hotel;
  final bool isLogin;

  HotelSuggestion({Key key, this.hotel, this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height(context, 10)),
          width: getWidth(context) - height(context, 32),
          height: getHeight(context) * 0.3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLeft(context),
              buildRight(context),
            ],
          ),
        ),
        if (!isLogin)
          Padding(
            padding: EdgeInsets.only(bottom: height(context, 10)),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, login),
              child: RichText(
                text: TextSpan(
                  text: "Đăng nhập",
                  style: TextStyle(
                    color: HexColor("#E56024"),
                    decoration: TextDecoration.underline,
                  ),
                  children: [
                    TextSpan(
                      text: " để được giá tốt hơn",
                      style: TextStyle(
                        color: HexColor("#000000"),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Divider(height: 1)
      ],
    );
  }

  Widget buildRight(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: width(context, 12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  hotel.name,
                  style: TextStyle(
                    color: HexColor("#2E3A59"),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(height: height(context, 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.from(<int>[1, 2, 3, 4]).map(
                    (e) {
                      return Icon(
                        Icons.star,
                        color: e <= int.parse(hotel.starRate)
                            ? HexColor("#E56024")
                            : Colors.grey,
                      );
                    },
                  ).toList(),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      color: HexColor("#8F9BB3"),
                    ),
                    SizedBox(width: 3),
                    Text(
                      hotel.totalRating,
                      style: TextStyle(
                        color: HexColor("#8F9BB3"),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.mode_comment,
                      color: HexColor("#8F9BB3"),
                    ),
                    SizedBox(width: 3),
                    Text(
                      hotel.totalComment,
                      style: TextStyle(
                        color: HexColor("#8F9BB3"),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: height(context, 8)),
            Row(
              children: [
                Icon(
                  Icons.place,
                  color: HexColor("#8F9BB3"),
                ),
                SizedBox(width: 3),
                Flexible(
                  child: Text(
                    hotel.address,
                    maxLines: 1,
                    style: TextStyle(
                      color: HexColor("#2E3A59"),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height(context, 8)),
            Row(
              children: [
                Icon(
                  Icons.near_me,
                  color: HexColor("#8F9BB3"),
                ),
                SizedBox(width: 3),
                Text(
                  "Cách tôi ${hotel.distance.toStringAsFixed(2)}km",
                  style: TextStyle(
                    color: HexColor("#2E3A59"),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Spacer(),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: HexColor("#8F9BB3"),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                text: "2h đầu:",
                children: [
                  TextSpan(
                    text: " ${hotel.afterHour}.000 đ",
                    style: TextStyle(
                      foreground: Paint()..shader = linearGradient,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height(context, 8)),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: HexColor("#8F9BB3"),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                text: "Qua đêm:",
                children: [
                  TextSpan(
                    text: " ${hotel.priceOn}.000 đ",
                    style: TextStyle(
                      foreground: Paint()..shader = linearGradient,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLeft(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/img_default.png',
            // image: hotel.thumbnail,
            image:
                "https://media.metrip.vn/tour/content/tranlylyy_23417065_1513077135444628_5015653672873361408_n.jpg",
            width: getWidth(context) * 0.35,
            height: getHeight(context) * 0.2,
            fit: BoxFit.fill,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: height(context, 12),
            ),
            margin: EdgeInsets.only(
              top: height(context, 12),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  HexColor("#F79441"),
                  HexColor("#F25F58"),
                ],
                stops: [0.4, 1.0],
              ),
            ),
            width: getWidth(context) * 0.35,
            child: Text(
              "Xem phòng",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
