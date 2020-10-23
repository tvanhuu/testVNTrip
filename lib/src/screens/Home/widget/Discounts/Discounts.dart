import 'package:flutter/material.dart';
import 'package:testExample1/src/helpers/index.dart';
import 'dart:math' as math;

class Discount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height(context, 12)),
      child: Stack(
        children: [
          Container(
            width: getWidth(context) - width(context, 32),
            height: getHeight(context) * 0.08,
            color: HexColor("#F5FDDA"),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: HexColor("#81BE33"),
                        ),
                        SizedBox(width: 4),
                        Text("Ưu đãi giảm 30% giá khi ..."),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: getHeight(context) * 0.08,
                  color: Colors.transparent,
                  child: CustomPaint(
                    painter: DashRectPainter(
                      color: HexColor("#81BE33"),
                      strokeWidth: 2.0,
                      gap: 5.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context, 16)),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("Đổi"),
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                  ),
                )
              ],
            ),
          ),
          CustomPaint(
            painter: CustomSticker(),
            child: Container(
              height: getHeight(context) * 0.08,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSticker extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double step = 1 / 7;
    double radius = size.width * 0.95;

    Paint paint = new Paint()
      ..color = HexColor("#81BE33")
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height * (step * 6));
    path.quadraticBezierTo(
      radius,
      size.height * (step * 5.5),
      size.width,
      size.height * (step * 5),
    );

    path.lineTo(size.width, size.height * (step * 5));
    path.lineTo(size.width, size.height * (step * 4));
    path.quadraticBezierTo(
      radius,
      size.height * (step * 3.5),
      size.width,
      size.height * (step * 3),
    );

    path.lineTo(size.width, size.height * (step * 3));
    path.lineTo(size.width, size.height * (step * 2));
    path.quadraticBezierTo(
      radius,
      size.height * (step * 1.5),
      size.width,
      size.height * (step * 1),
    );

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();

    double step = 1 / 7;
    double radius = size.width * 0.95;

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height * (step * 6));
    path.quadraticBezierTo(
      radius,
      size.height * (step * 5.5),
      size.width,
      size.height * (step * 5),
    );

    path.lineTo(size.width, size.height * (step * 5));
    path.lineTo(size.width, size.height * (step * 4));
    path.quadraticBezierTo(
      radius,
      size.height * (step * 3.5),
      size.width,
      size.height * (step * 3),
    );

    path.lineTo(size.width, size.height * (step * 3));
    path.lineTo(size.width, size.height * (step * 2));
    path.quadraticBezierTo(
      radius,
      size.height * (step * 1.5),
      size.width,
      size.height * (step * 1),
    );

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashRectPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  double gap;

  DashRectPainter(
      {this.strokeWidth = 5.0, this.color = Colors.red, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double y = size.height;

    Path _leftPath = getDashedPath(
      a: math.Point(0, 0),
      b: math.Point(0.001, y),
      gap: gap,
    );

    canvas.drawPath(_leftPath, dashedPaint);
  }

  Path getDashedPath({
    @required math.Point<double> a,
    @required math.Point<double> b,
    @required gap,
  }) {
    Size size = Size(b.x - a.x, b.y - a.y);
    Path path = Path();
    path.moveTo(a.x, a.y);
    bool shouldDraw = true;
    math.Point currentPoint = math.Point(a.x, a.y);

    num radians = math.atan(size.height / size.width);

    num dx = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    num dy = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= b.x && currentPoint.y <= b.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x, currentPoint.y)
          : path.moveTo(currentPoint.x, currentPoint.y);
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + dx,
        currentPoint.y + dy,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
