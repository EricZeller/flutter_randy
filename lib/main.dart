import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const RandomNumberGeneratorApp());

class RandomNumberGeneratorApp extends StatelessWidget {
  const RandomNumberGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          // Füge weitere Textstile hinzu, falls benötigt
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          // Füge weitere Textstile hinzu, falls benötigt
        ),
      ),
      themeMode: ThemeMode.system,
      home: const RandomNumberGeneratorScreen(),
    );
  }
}

class RandomNumberGeneratorScreen extends StatefulWidget {
  const RandomNumberGeneratorScreen({super.key});

  @override
  _RandomNumberGeneratorScreenState createState() =>
      _RandomNumberGeneratorScreenState();
}

class _RandomNumberGeneratorScreenState
    extends State<RandomNumberGeneratorScreen> {
  int _numOfRandomNumbers = 1;
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();
  List<int> _randomNumbers = [];

  void _generateRandomNumbers() {
    final int min = int.tryParse(_minController.text) ?? 0;
    final int max = int.tryParse(_maxController.text) ?? 100;
    final Random random = Random();

    setState(() {
      _randomNumbers = List.generate(
          _numOfRandomNumbers, (_) => min + random.nextInt(max - min + 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 65, 126),
        title: const Center(
            child: Text(
          'Randy',
          style: TextStyle(fontSize: 32),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _minController,
                    decoration: const InputDecoration(
                      labelText: 'Min Value',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _maxController,
                    decoration: const InputDecoration(
                      labelText: 'Max Value',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Number of Random Numbers: $_numOfRandomNumbers'),
            Slider(
              value: _numOfRandomNumbers.toDouble(),
              min: 1,
              max: 100,
              divisions: 99,
              label: _numOfRandomNumbers.toString(),
              onChanged: (double value) {
                setState(() {
                  _numOfRandomNumbers = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _generateRandomNumbers,
              icon: const Icon(Icons.shuffle),
              label: const Text('Generate'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _randomNumbers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Random Number ${index + 1}: ${_randomNumbers[index]}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
