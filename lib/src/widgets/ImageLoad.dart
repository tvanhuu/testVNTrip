// import 'package:flutter/material.dart';

// class ImageLoad extends StatefulWidget {
//   final String src;

//   const ImageLoad({Key key, this.src}) : super(key: key);
//   @override
//   _ImageLoadState createState() => _ImageLoadState();
// }

// class _ImageLoadState extends State<ImageLoad> {
//   bool _loaded = false;

//   String get src => widget.src;

//   var img = Image.network(src);

//   var placeholder = Image.network(
//       "https://kimhotel.com.vn/wp-content/uploads/2018/04/DDT1334-Edit-1.jpg");

//   @override
//   void initState() {
//     super.initState();
//     img.image.resolve(ImageConfiguration()).addListener(() {
//       if (mounted) {
//         setState(() => _loaded = true);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _loaded ? img : placeholder;
//   }
// }
