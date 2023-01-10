import 'package:flutter/material.dart';


class InitStartUp extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const InitStartUp({Key? key, required this.onInit, required this.child}) : super(key: key);

  @override
  State<InitStartUp> createState() => _InitStartUpState();
}

class _InitStartUpState extends State<InitStartUp> {
  bool _isInit = false;

  @override
  void initState() {
    widget.onInit();
    setState(() {
      _isInit = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isInit ? widget.child : const Scaffold();
  }
}
