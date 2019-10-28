import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String url;
  FullScreenImage(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
            child: PhotoView(
          imageProvider: NetworkImage(url),
        )),
      ),
    );
  }
}
