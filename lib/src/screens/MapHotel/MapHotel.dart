import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testExample1/src/models/Hotel.dart';

import 'bloc/MapBloc.dart';
import 'bloc/bloc.dart';

class MapHotel extends StatefulWidget {
  @override
  _MapHotelState createState() => _MapHotelState();
}

class _MapHotelState extends State<MapHotel> {
  GoogleMapController _controller;
  MapBloc mapBloc;

  List<Marker> _maker = [];
  Hotel _currentSelect;

  Future<Marker> addMarker(Hotel hotel,
      {Color bgColor = Colors.white, Color textColor = Colors.black}) async {
    return Marker(
      markerId: new MarkerId(hotel.name),
      position: new LatLng(double.parse(hotel.lat), double.parse(hotel.lng)),
      icon: BitmapDescriptor.fromBytes(
          await markerToBitmap(hotel.price, bgColor, textColor)),
      onTap: () => _onTapMaker(hotel),
    );
  }

  void _onTapMaker(Hotel hotel) async {
    // Get next marker
    int index = _maker.indexWhere(
      (element) => element.markerId.value == hotel?.name ?? "",
    );
    if (index != null && index > -1) {
      _maker[index] = await addMarker(
        hotel,
        bgColor: Colors.red,
        textColor: Colors.white,
      );
    }

    // Get current marker
    int lastIndex = _maker.indexWhere(
      (element) => element.markerId.value == _currentSelect?.name ?? "",
    );
    if (lastIndex != null && lastIndex > -1) {
      _maker[lastIndex] = await addMarker(
        _currentSelect,
        bgColor: Colors.white,
        textColor: Colors.black,
      );
    }

    setState(() {
      _maker = _maker;
      _currentSelect = hotel;
    });
  }

  Future<Uint8List> markerToBitmap(
    String label,
    Color bgColor,
    Color textColor,
  ) async {
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    DrawMarker marker = DrawMarker(
      label: label,
      bgColor: bgColor,
      tetxColor: textColor,
    );
    marker.paint(canvas, Size(120, 80));

    var image = await recorder.endRecording().toImage(120, 80);
    ByteData byte = await image.toByteData(format: ImageByteFormat.png);

    return byte.buffer.asUint8List();
  }

  void setListMarker(List<Hotel> hotel) async {
    List<Marker> lst = [];

    for (Hotel item in hotel) {
      lst.add(await addMarker(item));
    }

    setState(() {
      _maker = lst;
    });
  }

  @override
  void initState() {
    super.initState();

    mapBloc = MapBloc()..add(MapRequested());
  }

  @override
  void dispose() {
    mapBloc.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapBloc, MapState>(
        cubit: mapBloc,
        listener: (context, state) async {
          if (state is MapSuccess) {
            List<Marker> lst = [];
            for (Hotel item in state.hotels) {
              lst.add(await addMarker(item));
            }

            setState(() {
              _maker = lst;
            });
          }
        },
        builder: (context, state) {
          return buildContent();
        },
      ),
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
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(21.003067016601562, 105.7449690914168),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      markers: Set.from(_maker),
    );
  }

  Widget buildTitle() {
    return Text(
      "Title Map",
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class DrawMarker extends CustomPainter {
  final String label;
  final Color bgColor;
  final Color tetxColor;

  DrawMarker({this.label, this.bgColor, this.tetxColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = bgColor;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height * 0.8);
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(10));

    canvas.drawRRect(rRect, paint);

    Path path = Path();

    path.moveTo(size.width * 0.4, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width * 0.6, size.height * 0.8);
    path.moveTo(size.width * 0.4, size.height * 0.8);

    canvas.drawPath(path, paint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "$label,000",
        style: TextStyle(fontSize: 20, color: tetxColor),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
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
