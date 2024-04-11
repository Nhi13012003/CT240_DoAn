import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullImageView extends StatefulWidget {
  final List<Map<String, String>> imageUrls;
  final int initialIndex;

  const FullImageView(
      {super.key, required this.imageUrls, this.initialIndex = 0});

  @override
  _FullImageViewState createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  int _currentIndex = 0;
  double _offsetX = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _navigateToNextImage() {
    setState(() {
      if (_currentIndex < widget.imageUrls.length - 1) {
        _currentIndex++;

        _offsetX = 0;
      }
    });
  }

  void _navigateToPreviousImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _offsetX = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              _offsetX = details.primaryDelta!;
            });
          },
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Vuốt sang trái
              _navigateToPreviousImage();
            } else if (details.primaryVelocity! < 0) {
              // Vuốt sang phải
              _navigateToNextImage();
            }
          },
          child: CachedNetworkImage(
            imageUrl: widget.imageUrls[_currentIndex]['url']!,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
