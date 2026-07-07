import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reseaux_1parametre/suiteCarre.dart';

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

  TextEditingController positionController = TextEditingController();

  SuiteCarreResultat? suiteCarreResultat;

  void getHttpComplex() async {
    try {
      var response = await Dio().get(
        'http://10.0.2.2:8080/exam/suite-carre/${positionController.text}',
      );
      print(response);
      setState(() {
        suiteCarreResultat = SuiteCarreResultat.fromJson(response.data);
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
              controller: positionController,
            ),
            ElevatedButton(
                onPressed: (){
                  getHttpComplex();
                },
                child: Text('Calculer')
            ),
            Text('Position : ${suiteCarreResultat?.position}'),
            Text('precedent : ${suiteCarreResultat?.precedent}'),
            Text('valeur : ${suiteCarreResultat?.valeur}'),
            Text('suivant : ${suiteCarreResultat?.suivant}'),
            Text('pair : ${suiteCarreResultat?.pair}'),
            Text('message : ${suiteCarreResultat?.message}')


          ],
        ),
      ),

    );
  }
}
