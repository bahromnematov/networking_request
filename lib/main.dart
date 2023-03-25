import 'package:flutter/material.dart';
import 'package:networking_request/pages/network_page.dart';
import 'package:networking_request/pages/product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NetworkPage(),
      routes: {
        ProductPage.route: (context) => const ProductPage(),
        NetworkPage.route: (context) => const NetworkPage(),

      },

    );
  }
}
