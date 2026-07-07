import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reseaux_simple/Cinema.dart';
import 'package:reseaux_simple/Livraison.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  TextEditingController ageControlleur = TextEditingController();
  TextEditingController jourControlleur = TextEditingController();

  TextEditingController distanceControlleur = TextEditingController();
  TextEditingController poidsControlleur = TextEditingController();

  int reponse = -1;
  Cinema? cinema;
  Livraison? livraison;

  void getHttpComplex() async {
    try {
      var response = await Dio().get(
        'http://10.0.2.2:8080/exam/cinema/${ageControlleur.text}/${jourControlleur.text}',
      );
      print(response);
      setState(() {
        cinema = Cinema.fromJson(response.data);
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erreur reseau')));
    }
  }
  // void getHttpComplex() async {
  //   try {
  //     var response = await Dio().get(
  //       'http://10.0.2.2:8080/exam/livraison/${distanceControlleur.text}/${poidsControlleur.text}',
  //     );
  //     print(response);
  //     setState(() {
  //       livraison = Livraison.fromJson(response.data);
  //     });
  //   } catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text('Erreur reseau')));
  //   }
  // }



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
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextField(
                controller: ageControlleur,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextField(
                controller: jourControlleur,
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  getHttpComplex();
                },
                child: Text('Calculer')
            ),
            Text('Âge : ${cinema?.age}'),
            Text('Jour : ${cinema?.jour}'),
            Text('Catégorie : ${cinema?.categorie}'),
            Text('Prix de base : ${cinema?.prixBase}'),
            Text('Rabais : ${cinema?.rabais}'),
            Text('Prix final : ${cinema?.prixFinal}'),
            Text('Message : ${cinema?.message}')
            // Padding(
            //   padding: const EdgeInsets.all(28.0),
            //   child: TextField(
            //     controller: distanceControlleur,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(28.0),
            //   child: TextField(
            //     controller: poidsControlleur,
            //   ),
            // ),
            // ElevatedButton(
            //     onPressed: (){
            //       getHttpComplex();
            //     },
            //     child: Text('Calculer')
            // ),
            // Text('Distance : ${livraison?.distance}'),
            // Text('Poids : ${livraison?.poids}'),
            // Text('Frais de distance : ${livraison?.fraisDistance}'),
            // Text('Frais de poids : ${livraison?.fraisPoids}'),
            // Text('Total : ${livraison?.total}'),
            // Text('Livraison gratuite : ${livraison?.livraisonGratuite}'),
          ],
        ),
      ),

    );
  }
}
