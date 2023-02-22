import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GameTile extends StatelessWidget {
  String title;
  String imageUrl;
  Function onTap;
  String percentage;


  GameTile({Key? key, required this.title, required this.imageUrl, required this.onTap, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: theme.colorScheme.background,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Spacer(),
            Text(title),
            Spacer(),
            Row(
              children: [
                RatingBarIndicator(
                  rating: double.parse(percentage),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 1,
                  itemSize: 30,
                  direction: Axis.vertical,
                ),
                Text('${(double.parse(percentage)*100).toStringAsFixed(0)}%', style: TextStyle(color: Colors.amber)),
              ]
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
