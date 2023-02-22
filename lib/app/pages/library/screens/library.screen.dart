
import 'package:albi_hry/app/pages/library/providers/library.provider.dart';
import 'package:albi_hry/app/pages/library/widgets/empty_library.dart';
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

// import 'package:albi_hry/features/library/providers/library.provider.dart';
// import 'package:albi_hry/features/library/widgets/empty_library.dart';
// import 'package:albi_hry/shared/utils/loading-widget/loading-indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../shared/utils/loading-widget/loading.provider.dart';
// import '../widgets/games_list.dart';
//
// class LibraryScreen extends StatelessWidget {
//   const LibraryScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final libraryProvider = Provider.of<LibraryProvider>(context);
//
//     return LoadingIndicator(
//       child: Container(
//           margin: const EdgeInsets.all(10),
//           child: libraryProvider.games.isEmpty
//               ? const EmptyLibrary()
//               :  Column(
//             children: [
//               Container(
//                 height: 30,
//                 child: ListView(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     Text(
//                       "Moje hry",
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.add),
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ],
//                 ),
//               ),
//               const GamesList(),
//             ],
//           )),
//     );
//   }
// }