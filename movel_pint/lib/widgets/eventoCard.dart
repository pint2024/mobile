import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String imageUrl;

  const EventCard({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 30,
              ),
              title: Text(title),
              subtitle: Text('$location • $date • $time'),
            ),
            SizedBox(height: 8),
            Center(
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildIconWithCount(Icons.photo_library_outlined, '5'),
                SizedBox(width: 20),
                _buildIconWithCount(Icons.comment_outlined, '5'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData iconData, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        SizedBox(width: 3),
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
