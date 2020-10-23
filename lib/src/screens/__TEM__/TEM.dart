import 'package:flutter/material.dart';
import 'package:testExample1/src/helpers/Dimension.dart';

class TEM extends StatefulWidget {
  @override
  _TEMState createState() => _TEMState();
}

class _TEMState extends State<TEM> {
  double rating = 4.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget buildContent() {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: width(context, 16)),
        color: Colors.white,
        // child: Center(
        //   child: Container(
        //     width: 120,
        //     height: 80,
        //     child: CustomPaint(
        //       painter: MyPainter(label: "700000"),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      "Title somethings",
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final String label;

  MyPainter({this.label});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.orange;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height * 0.8);
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(10));

    canvas.drawRRect(rRect, paint);

    paint.color = Colors.orange;

    Path path = Path();

    path.moveTo(size.width * 0.4, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width * 0.6, size.height * 0.8);
    path.moveTo(size.width * 0.4, size.height * 0.8);

    // path.lineTo(0, size.height * 0.8);
    // path.lineTo(size.width * 0.4, size.height * 0.8);
    // path.lineTo(size.width * 0.5, size.height);
    // path.lineTo(size.width * 0.6, size.height * 0.8);
    // path.lineTo(size.width, size.height * 0.8);
    // path.lineTo(size.width, 0);
    // path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "$label",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width - 10);

    textPainter.paint(
      canvas,
      Offset(
        size.width / 2 - textPainter.size.width / 2,
        size.height * 0.8 / 2 - textPainter.size.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
