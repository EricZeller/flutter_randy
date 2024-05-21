import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'dart:math';

void main() => runApp(const RandomNumberGeneratorApp());

class RandomNumberGeneratorApp extends StatelessWidget {
  const RandomNumberGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
          darkColorScheme = ColorScheme.fromSeed(
              seedColor: Colors.deepPurple, brightness: Brightness.dark);
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'Poppins'),
              bodyMedium: TextStyle(fontFamily: 'Poppins'),
              bodySmall: TextStyle(fontFamily: 'Poppins'),
              titleLarge: TextStyle(fontFamily: 'Poppins'),
              titleMedium: TextStyle(fontFamily: 'Poppins'),
              titleSmall: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontFamily: 'Poppins'),
              bodyMedium: TextStyle(fontFamily: 'Poppins'),
              bodySmall: TextStyle(fontFamily: 'Poppins'),
              titleLarge: TextStyle(fontFamily: 'Poppins'),
              titleMedium: TextStyle(fontFamily: 'Poppins'),
              titleSmall: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          themeMode: ThemeMode.system,
          home: const RandomNumberGeneratorScreen(),
        );
      },
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
        title: Center(child: Text('Randy', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 36, color: Theme.of(context).colorScheme.onPrimaryContainer),)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
                      labelText: 'Min',
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
                      labelText: 'Max',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Default: 0-100'),
            const SizedBox(height: 20),
            Text('Number of Random Numbers: $_numOfRandomNumbers'),
            Slider(
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
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
              icon: const Icon(Icons.shuffle),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onTertiary),
              onPressed: _generateRandomNumbers,
              label: const Text('Generate'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _randomNumbers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Text(
                          'Random Number ${index + 1}: ${_randomNumbers[index]}', style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),),
                      tileColor: Theme.of(context).colorScheme.secondaryContainer,
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
