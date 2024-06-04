import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

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
          initialRoute: '/home',
          routes: {
            '/home': (context) => const RandomNumberGeneratorScreen(),
            '/about': (context) => const AboutPage(),
          },
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

  final Uri _githubUrl =
      Uri.parse('https://github.com/EricZeller/flutter-randy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Randy',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 36,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            icon: const Icon(Icons.info_outline),
            tooltip: "About",
          ),
          IconButton(
            onPressed: () => _launchUrl(_githubUrl),
            icon: const Icon(Icons.data_object),
            tooltip: "Source",
          ),
        ],
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(
                        'Random Number ${index + 1}: ${_randomNumbers[index]}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      tileColor:
                          Theme.of(context).colorScheme.secondaryContainer,
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

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          textTheme: TextTheme(
            bodyLarge: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            bodyMedium: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            bodySmall: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            titleLarge: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            titleMedium: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            titleSmall: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: TextTheme(
            bodyLarge: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            bodyMedium: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            bodySmall: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            titleLarge: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            titleMedium: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            titleSmall: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
        themeMode: ThemeMode.system,
        home: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          appBar: AppBar(
            foregroundColor: Theme.of(context).colorScheme.surfaceTint,
            backgroundColor: Theme.of(context).colorScheme.surfaceDim,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text("About"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'About This App',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'This app is designed to generate random numbers within a specified range. You can select the number of random numbers to generate and specify the range for the random numbers. This app uses Flutter, a powerful framework for building cross-platform apps with a single codebase.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Features',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '• Generate random numbers within a specified range\n'
                  '• Select the number of random numbers to generate\n'
                  '• Beautiful and responsive design\n'
                  '• Supports light and dark themes\n'
                  '• Uses Material 3 design principles',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'How to Use',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '1. Enter the minimum value in the Min Value field.\n'
                  '2. Enter the maximum value in the Max Value field.\n'
                  '3. Use the slider to select the number of random numbers to generate.\n'
                  '4. Press the "Generate Random Numbers" button to generate the numbers.\n'
                  '5. The generated random numbers will be displayed in a list below the button.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'About the Developer',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'This app was developed by [Your Name], a passionate Flutter developer who loves creating beautiful and functional applications. For more information, visit [your website or contact information].',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Acknowledgements',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Special thanks to the Flutter community for their support and contributions. This app would not have been possible without the amazing resources and documentation provided by the Flutter team.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'License',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'This project is licensed under the GPL v3 License - see the LICENSE file in the GitHub repository for details.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      );
    });
  }
}
