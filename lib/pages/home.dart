import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randy'),
        centerTitle: true,
      ),
      body: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero)),
          hintText: 'from',
        ),
        keyboardType: TextInputType.number,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan[100],
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
