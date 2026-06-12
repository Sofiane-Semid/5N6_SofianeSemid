import 'package:flutter/cupertino.dart';
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
      // Écran affiché au démarrage de l'application
      home: const MyHomePage(),
      // Déclaration des routes nommées
      // '/second' est associé à la page SecondScreen
      routes: {
        '/second' : (context) => SecondScreen(),
      },
    );
  }
}

// Deuxième écran de l'application
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});
  @override
  State<SecondScreen> createState() => _SecondScreen();
}
// Premier écran de l'application
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Contrôleur permettant de récupérer le texte
  // écrit dans le TextField
  final TextEditingController _myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Page 1'),
      ),
      body: Center(
        child : Column(

          // Champ texte relié au contrôleur
          // Le texte saisi pourra être lu avec :
          // _myController.text
          children: [
            TextField( controller: _myController,),

            // Lorsque le bouton est cliqué :
            // 1. On navigue vers la route '/second'
            // 2. On envoie le texte du TextField
            ElevatedButton(
                onPressed: (){
              Navigator.pushNamed(context, '/second',
                // Donnée transmise au deuxième écran
                arguments: _myController.text,);
            },
                child: Text("Page 2"))
          ],
        ),
      ),
    );
  }
}

class _SecondScreen extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {

    // Récupération de la donnée envoyée
    // par Navigator.pushNamed(..., arguments: ...)
    final message = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(// Affichage de la valeur reçue

      child: Text(message
        ),
      ),
    );
  }
}



