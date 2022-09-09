import 'package:cryptospace/models/crypto.dart';
import 'package:cryptospace/screens/detail_screen.dart';
import 'package:cryptospace/screens/home_screem.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case DetailScreen.id:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DetailScreen(
          crypto: routeSettings.arguments as Crypto,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
