import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatefulWidget {
  final File image;
  const ImagePage({required this.image, super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Image'),
              toolbarHeight: MediaQuery.of(context).size.height * 0.08,
              leading: IconButton(
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            SliverFillRemaining(
              child: PageView(
                
                children: [
                  // InteractiveViewer(child: Image.file(widget.image)),
                  PhotoView(imageProvider: FileImage(widget.image)),
                  
                  // child: Image.file(widget.image)),
                ],
              ),
            ),
          ],
          
        ),
      ),
    );
  }
}
