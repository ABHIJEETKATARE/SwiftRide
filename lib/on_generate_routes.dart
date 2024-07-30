import 'package:flutter/material.dart';
import 'package:internshala_assignment/features/SearchDestination/search_screen.dart';
import 'package:internshala_assignment/features/auth/screens/auth_screen.dart';
import 'package:internshala_assignment/features/home/screens/home_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          return AuthScreen();
        },
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          return const SearchScreen();
        },
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text("not exist"),
          ),
        ),
      );
  }
}
