import 'package:flutter/material.dart';

class EmptyLibrary extends StatelessWidget {
  const EmptyLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Moje hry', style: theme.textTheme.headline2),
        ),
        const Spacer(),
        const Center(
          child: Icon(
            Icons.library_books_outlined,
            size: 100,
            color: Colors.grey,
          ),
        ),
        const Center(
          child: Text(
            'Knihovna je prázdná',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        const Center(
          child: Text(
            'Přidejte hru do knihovny',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 70),
        Center(
          child: Transform.rotate(
            angle: -3.14 / 6,
            child: Container(
              margin: const EdgeInsets.only(left: 150),
              width: 200,
              child: Image.asset(
                'assets/backgrounds/background-arrow.png',
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
