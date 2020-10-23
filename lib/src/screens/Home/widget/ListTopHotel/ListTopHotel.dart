import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/helpers/index.dart';
import 'package:testExample1/src/models/Hotel.dart';

import 'bloc/bloc.dart';

class ListTopHotel extends StatefulWidget {
  @override
  _ListTopHotelState createState() => _ListTopHotelState();
}

class _ListTopHotelState extends State<ListTopHotel>
    with AutomaticKeepAliveClientMixin<ListTopHotel> {
  TopHoteBloc topHoteBloc = TopHoteBloc();

  @override
  void initState() {
    super.initState();
    topHoteBloc.add(TopHoteRequested());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<TopHoteBloc, TopHoteState>(
      cubit: topHoteBloc,
      builder: (context, state) {
        if (state is TopHoteSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height(context, 16)),
                child: Text(
                  "Top 5 khách sạn nổi bật",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: getHeight(context) * 0.16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.topHotel.length,
                  itemBuilder: (context, index) {
                    return HotelTop(topHotel: state.topHotel[index]);
                  },
                ),
              )
            ],
          );
        }

        return SizedBox();
      },
    );
  }
}

class HotelTop extends StatelessWidget {
  final Hotel topHotel;

  HotelTop({Key key, this.topHotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: height(context, 16)),
      padding: EdgeInsets.all(width(context, 8)),
      width: getWidth(context) * 0.6,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            // topHotel.thumbnail,
            "https://images.foody.vn/images/blogs/foody-l%E1%BB%93ng-636408146680532170.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topHotel.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: height(context, 3)),
          Row(
            children: [
              Icon(
                Icons.place,
                color: Colors.white,
              ),
              SizedBox(width: width(context, 3)),
              Flexible(
                child: Text(
                  topHotel.address,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
