import 'package:clima_flutter_personal/screens/loading_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Clima());
}

class Clima extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
