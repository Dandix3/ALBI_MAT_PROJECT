import 'package:albi_hry/features/library/providers/library.provider.dart';
import 'package:albi_hry/features/library/widgets/empty_library.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/games_list.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final libraryProvider = Provider.of<LibraryProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      child: libraryProvider.games.isEmpty
          ? const EmptyLibrary()
          : const GamesList(),
    );
  }
}
