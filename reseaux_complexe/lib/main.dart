import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reseaux_complexe/Fibonacci.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  TextEditingController nameController = TextEditingController();

  FibonacciResultat? fibonacciResultat;

  void getHttpComplex(String nom) async {
    try {
      var response = await Dio().get(
        'http://10.0.2.2:8080/truc/complexe?name=$nom',
      );
      print(response);

      setState(() {
        fibonacciResultat = FibonacciResultat.fromJson(response.data);
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erreur reseau')));
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: nameController,
            ),
            ElevatedButton(
                onPressed: (){
                  getHttpComplex(nameController.text);
                },
                child: Text('Calculer')
            ),
            Text('Position : ${fibonacciResultat?.position}'),
            Text('precedent : ${fibonacciResultat?.precedent}'),
            Text('valeur : ${fibonacciResultat?.valeur}'),
            Text('suivant : ${fibonacciResultat?.suivant}'),
            Text('pair : ${fibonacciResultat?.pair}'),
            Text('message : ${fibonacciResultat?.message}')

          ],
        ),
      ),

    );
  }
}
