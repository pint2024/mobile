import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

class AlbumSliderPage extends StatelessWidget {
  final List<String> albumImages;

  AlbumSliderPage({required this.albumImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 1.0,
          ),
          itemCount: albumImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _showImageDetail(context, albumImages[index]);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  albumImages[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 3, onItemTapped: (int ) {  },
      ),
    );
  }

  void _showImageDetail(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailPage(imageUrl: imageUrl),
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  ImageDetailPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
