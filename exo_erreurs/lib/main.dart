import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  final TextEditingController dividendeController = TextEditingController();
  final TextEditingController diviseurController = TextEditingController();

  String resultat = "";
  String message = "";

  void diviser() async{
    String dividende = dividendeController.text;
    String diviseur = diviseurController.text;
    try {
      var response = await Dio().get(
        'https://examen-final-a24.azurewebsites.net/Exam2024/Division/$dividende/$diviseur',
      );
      print("Réponse serveur : ${response.data}");

      //met a jour la valeur
      setState(() {
        resultat = response.data['resultat'].toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Résultat : ${response.data['resultat']}"),
        ),
      );
    }
    // Erreur code 400
    on DioException catch(e){
      //affiche code erreur
      print("Status code : ${e.response?.statusCode}");

      //affiche message erreur
      print("Erreur serveur : ${e.response?.data}");

      if(e.response?.statusCode == 400){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Impossible d'effectuer une division par 0."),
          ),
        );

        //met a jour la valeur
        setState(() {
          resultat = "0";
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Impossible de communiquer avec le serveur."),
          ),
        );

        //met a jour la valeur
        setState(() {
          resultat = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: dividendeController,
                decoration: const InputDecoration(
                  labelText: 'Dividende',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: diviseurController,
                decoration: const InputDecoration(
                  labelText: 'Diviseur',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: diviser,
              child: const Text('Diviser'),
            ),
            const SizedBox(height: 20),
            Text("Résultat : $resultat"),
          ],
        ),


    );
  }
}
