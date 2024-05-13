import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Launch Page'),
      ),
      body: const Column(
        children: [
          Text('hello Launch'),
        ],
      ),
    );
  }
}
