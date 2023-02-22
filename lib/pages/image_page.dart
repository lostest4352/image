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
  double _scale = 1.0;
  Offset _position = Offset.zero;

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
                  // PhotoView(imageProvider: FileImage(widget.image)),

                  GestureDetector(
                    onDoubleTap: () {
                      double maxScale = 4.0;
                      double minScale = 1.0;

                      double currentScale = _scale;

                      if (currentScale > minScale) {
                        currentScale = minScale;

                        _position = Offset.zero;
                      } else {
                        currentScale = currentScale * 2.0;
                      }

                      currentScale = currentScale.clamp(minScale, maxScale);

                      setState(() {
                        _scale = currentScale;
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        if (_scale > 1.0) {
                          setState(() {
                            // _position += details.delta;
                            // Offset.zero;

                            Offset newPosition = _position + details.delta;
                            Size screenSize = MediaQuery.of(context).size;
                            double maxPositionX =
                                (screenSize.width / 2) * (_scale - 1);
                            double maxPositionY =
                                (screenSize.height / 2) * (_scale - 1);
                            Offset maxPosition =
                                Offset(maxPositionX, maxPositionY);

                            _position = Offset(
                              newPosition.dx
                                  .clamp(-maxPosition.dx, maxPosition.dx),
                              newPosition.dy
                                  .clamp(-maxPosition.dy, maxPosition.dy),
                            );
                          });
                        }
                      });
                    },
                    child: Transform.scale(
                      scale: _scale,
                      child: Transform.translate(
                        offset: _position,
                        child: Image.file(
                          widget.image,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
