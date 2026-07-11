import 'package:flutter/material.dart';

void main() {
  runApp(const OmniCartApp());
}

class OmniCartApp extends StatelessWidget {
  const OmniCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OmniCart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to OmniCart - AI-Powered E-commerce'),
        ),
      ),
    );
  }
}
