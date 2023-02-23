import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: 100,
      width: size.width,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.values[1],
              child: Container(
                width: 100,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      "Skupina",
                      style: theme.textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
