import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final AssetImage? userImage;
  final String? notificationText;
  final String? notificationTime;

  const NotificationCard({
    this.userImage,
    this.notificationText,
    this.notificationTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color.fromARGB(255, 242, 248, 251),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(right: 8.0), // Ajuste a quantidade de espaço à direita conforme necessário
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Images/logo2.png'),
                  radius: 20, 
                ),
              ),
            SizedBox(width: 15), 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationText ?? 'O Joao Santos ouviu musica de kpop 134 vezes no dia de sabado, deve ser levado ao hospital psiquiatrico',
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 0), 
                      _buildIconWithCount(Icons.calendar_month, ''),
                      SizedBox(width: 3), 
                      Text(
                        notificationTime ?? '10/2/2023',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
