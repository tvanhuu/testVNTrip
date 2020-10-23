import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testExample1/src/helpers/index.dart';

import 'bloc/bloc.dart';

class BannerApp extends StatefulWidget {
  @override
  _BannerAppState createState() => _BannerAppState();
}

class _BannerAppState extends State<BannerApp>
    with AutomaticKeepAliveClientMixin<BannerApp> {
  PageController pageController;
  BanneBloc bannerBloc;
  int currentIndex = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();

    bannerBloc = BanneBloc()..add(BanneRequested());
    pageController = PageController(initialPage: 0);
  }

  void autoNextBanner(int maxPage) {
    if (timer != null) timer.cancel();
    timer = Timer(Duration(seconds: 5), () {
      int nextPage = pageController.page.toInt() + 1;

      pageController.animateToPage(
        nextPage < maxPage ? nextPage : 0,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    bannerBloc.close();
    timer.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<BanneBloc, BanneState>(
      cubit: bannerBloc,
      builder: (context, state) {
        if (state is BanneSuccess) {
          autoNextBanner(state.banners.length);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: width(context, 12)),
                child: Text(
                  "Khuyến mãi trong tháng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  buildListBanner(state),
                  Positioned(
                    bottom: 20,
                    child: Row(
                      children: List.generate(
                        state.banners.length,
                        (index) => index,
                      )
                          .map(
                            (e) => Icon(
                              Icons.fiber_manual_record,
                              size: 15,
                              color: currentIndex == e
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              )
            ],
          );
        }

        return SizedBox();
      },
    );
  }

  Widget buildListBanner(BanneSuccess state) {
    return Container(
      height: getHeight(context) * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: PageView.builder(
          controller: pageController,
          itemCount: state.banners.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return FadeInImage.assetNetwork(
              placeholder: 'assets/banner.jpeg',
              // image: state.banners[index].image,
              image:
                  "https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2020/08/top-ung-dung-dat-phong-theo-gio-1.jpg",
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }
}
