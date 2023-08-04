import 'package:flutter/material.dart';
import 'package:geoservise_test/pages/home.dart';
import 'package:geoservise_test/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geoservice Test Web Application',
      theme: applicationTheme,
      home: HomePage(),
    );
  }
}