import 'package:flutter/material.dart';

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

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> ordreCorrect = [
    'Adam',
    'Bilal',
    'Charles',
    'David',
    'Émile',
  ];
  List<String> prenoms = [];

  @override
  void initState(){
    super.initState();
    prenoms = List.from(ordreCorrect);
    prenoms.shuffle();
  }

  void monterElement(int index) {
    if (index > 0) {
      final temp = prenoms[index];
      prenoms[index] = prenoms[index - 1];
      prenoms[index - 1] = temp;
      _verifierOrdre();
    }
  }

  void descendreElement(int index) {
    if (index < prenoms.length - 1) {
      final temp = prenoms[index];
      prenoms[index] = prenoms[index + 1];
      prenoms[index + 1] = temp;
      _verifierOrdre();
    }
  }

  void _verifierOrdre() {
    setState(() {});
    bool estOrdonne = true;
    for (int i = 0; i < prenoms.length; i++) {
      if (prenoms[i] != ordreCorrect[i]) {
        estOrdonne = false;
        break;
      }
    }
    if (estOrdonne) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bravo!'),
          content: const Text('Vous avez remis la liste dans le bon ordre!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => prenoms.shuffle());
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordre Alphabétique'),
      ),
      body: ListView.builder(
        itemCount: prenoms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(prenoms[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: index > 0 ? () => monterElement(index) : null,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: index < prenoms.length - 1 ? () => descendreElement(index) : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
