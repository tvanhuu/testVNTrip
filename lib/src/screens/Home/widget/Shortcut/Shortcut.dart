import 'package:flutter/material.dart';
import 'package:testExample1/src/helpers/index.dart';

class Category {
  String image;
  String name;

  Category({String image, String name}) {
    this.image = image;
    this.name = name;
  }
}

List<Category> category = [
  new Category(image: "assets/ic-wallet.png", name: "Rẻ nhất"),
  new Category(image: "assets/ic-map.png", name: "Gần nhất"),
  new Category(image: "assets/ic-hotel.png", name: "Mới nhất"),
  new Category(image: "assets/ic-saved.png", name: "Ưa thích"),
];

class Shortcut extends StatefulWidget {
  @override
  _ShortcutState createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height(context, 24)),
          child: Text(
            "Bạn có thể tìm kiếm nhanh",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: getWidth(context) - width(context, 32),
          height: getHeight(context) * 0.13,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: category.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        category[index].image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        category[index].name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
