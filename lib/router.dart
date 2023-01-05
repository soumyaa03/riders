import 'package:flutter/material.dart';
import 'package:riders/screens/add_rider.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AddRider.routeName:
      return MaterialPageRoute(builder: (((context) => const AddRider())));

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('error'),
          ),
        ),
      );
  }
}
