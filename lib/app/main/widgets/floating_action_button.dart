import 'package:albi_hry/app/pages/auth/providers/auth.provider.dart';
import 'package:albi_hry/app/pages/auth/screens/login.screen.dart';
import 'package:albi_hry/app/pages/auth/widgets/text_field_form.dart';
import 'package:albi_hry/app/pages/library/providers/library.provider.dart';
import 'package:albi_hry/app/pages/user/providers/user-friend.provider.dart';
import 'package:albi_hry/app/pages/user/providers/user.provider.dart';
import 'package:albi_hry/app/widgets/loading-widget/loading-indicator.dart';
import 'package:albi_hry/app/widgets/loading-widget/loading.provider.dart';
import 'package:albi_hry/common/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../screen_type.dart';


class FloatingActionBtn extends StatelessWidget {
  final ScreenType screenType;

  final controller = TextEditingController();

  User? searchedFriend;

  FloatingActionBtn({Key? key, required this.screenType}) : super(key: key);

  Icon getIcon() {
    switch (screenType) {
      case ScreenType.Games:
        return Icon(Icons.qr_code_scanner);
      case ScreenType.Nothing:
        return Icon(Icons.search);
      case ScreenType.Profile:
        return Icon(Icons.edit);
      case ScreenType.Friends:
        return Icon(Icons.person_add);
    }
  }

  //FlutterBarcodeScanner asd = FlutterBarcodeScanner();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final libraryProvider = Provider.of<LibraryProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userFriendProvider = Provider.of<UserFriendProvider>(context, listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);

    Future<void> scanBarcode() async {
      await FlutterBarcodeScanner.scanBarcode(
          "#ffffff", "Zpět", true, ScanMode.BARCODE)
          .then((value) => {
            if (value != "-1") {
              libraryProvider.fetchGame(value, context).then((value) {
                if (value != null) {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("Chcete přidat hru do knihovny?"),
                      content: Row(
                        children: [
                          Text("Načtená hra: "),
                          Text(value.name, style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Zrušit"),
                        ),
                        TextButton(
                          onPressed: () {
                            libraryProvider.addGame(value);
                            Navigator.of(context).pop();
                          },
                          child: Text("Přidat"),
                        ),
                      ],
                    );
                  });
                }
              })
            }
        //todo: pokud to najde víc her tak zobrazit dialog že ještě má naskenovat druhý qr kód a po odkliku zapnout scener
      });
    }


    Future<void> findFriend(BuildContext context) async {
      loadingProvider.setLoading(true);
      await userProvider.findUser(controller.text, context).then((value) {
        loadingProvider.setLoading(false);
        if (value is User) {
          Navigator.of(context).pop();
          controller.clear();
          showDialog(
            context: context,
            builder: (context) => LoadingIndicator(
              child: AlertDialog(
                icon: Icon(Icons.person_add,
                    color: theme.colorScheme.tertiary),
                title: const Text('Přidat přitele'),
                content: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://picsum.photos/200'),
                    ),
                    const SizedBox(width: 20),
                    Text(value.nickname),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Zrušit'),
                  ),
                  TextButton(
                    onPressed: () {
                      userFriendProvider.addFriend(value.id);
                      userFriendProvider.setFriendStatus();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Přidat'),
                  ),
                ],
              ),
            ),
          );
        } else {
          Navigator.of(context).pop();
        }
      });
    }

    Future<void> doAction() async {
      switch (screenType) {
        case ScreenType.Games:
          authProvider.isLoggedIn().then((value) => {
                if (value)
                  {scanBarcode()}
                else
                  {Navigator.of(context).pushNamed(LoginScreen.routeName)}
              });
          break;
        case ScreenType.Nothing:
          // TODO: Handle this case.
          break;
        case ScreenType.Profile:
          // TODO: Handle this case.
          break;
        case ScreenType.Friends:
          await authProvider.isLoggedIn().then((value) async {
            if (value) {
              showDialog(
                context: context,
                builder: (context) => LoadingIndicator(
                  child: AlertDialog(
                    icon: Icon(Icons.person_add,
                        color: theme.colorScheme.tertiary),
                    title: const Text('Přidat přitele'),
                    content: Container(
                        child: TextFieldForm(
                          label: 'Nickname',
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          controller: controller,
                          textInputAction: TextInputAction.done,
                          isForm: false,
                        )
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Zrušit'),
                      ),
                      TextButton(
                        onPressed: () {
                          findFriend(context);
                        },
                        child: const Text('Vyhledat'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            }
          });

          break;
      }
    }

    return FloatingActionButton(
      backgroundColor: Colors.white,
      splashColor: theme.colorScheme.tertiary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      onPressed: doAction,
      child: getIcon(),
    );
  }
}
