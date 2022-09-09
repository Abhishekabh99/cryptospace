import 'package:cryptospace/router.dart';
import 'package:cryptospace/screens/home_screem.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Cryptospace());
}

class Cryptospace extends StatelessWidget {
  const Cryptospace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: (settings) => generateRoute(settings),
      initialRoute: HomeScreen.id,
    );
  }
}
