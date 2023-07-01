import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.pink,
      ),
      home: const HomePage(),
    ),
  );
}
