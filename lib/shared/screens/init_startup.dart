import 'package:flutter/material.dart';


class InitStartUp extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const InitStartUp({Key? key, required this.onInit, required this.child}) : super(key: key);

  @override
  State<InitStartUp> createState() => _InitStartUpState();
}

class _InitStartUpState extends State<InitStartUp> {

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
