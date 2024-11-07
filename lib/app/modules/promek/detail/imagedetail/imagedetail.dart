import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;

  const ImageDetailScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Foto'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
