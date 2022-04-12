import 'package:flutter/material.dart';

class InitScreen extends StatefulWidget {
  static const id = "/InitScreen";

  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text('test'),
        ),
      ],
    );
  }
}
