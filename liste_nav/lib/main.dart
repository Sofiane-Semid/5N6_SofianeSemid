import 'package:flutter/material.dart';


// Modèle de données utilisé dans l'application
// Chaque Truc possède un id et un nom
class Truc{
  final int id;
  final String nom;

  Truc(this.id, this.nom);
}

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // Premier écran affiché au lancement de l'application
      home: const MyHomePage(title: 'List'),

      // Déclaration des routes nommées
      // '/second' permet d'ouvrir SecondScreen
      routes: {
        '/second' : (context) => SecondScreen(),
      },
    );
  }
}

// Deuxième écran
class SecondScreen extends StatefulWidget{
  @override
  State<SecondScreen> createState() => _SecondScreen();
}

// Premier écran
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    // Liste contenant 5 objets Truc
    final List<Truc> trucs = [
      Truc(1, "manette"),
      Truc(2, "ps5"),
      Truc(3, "écran"),
      Truc(4, "chaussures"),
      Truc(5, "t-shirt"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      // Affichage de la liste des Truc
      body: ListView(
        children:[

          // Chaque ListTile représente un Truc
          // Lors du clic, on navigue vers le deuxième écran
          // et on envoie l'objet Truc sélectionné

          ListTile(
            title: Text(trucs[0].nom),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second',

                // Objet envoyé au deuxième écran
                arguments: trucs[0],
              );
            },
          ),

          ListTile(
            title: Text(trucs[1].nom),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second',
                arguments: trucs[1],
              );
            },
          ),

          ListTile(
            title: Text(trucs[2].nom),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second',
                arguments: trucs[2],
              );
            },
          ),

          ListTile(
            title: Text(trucs[3].nom),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second',
                arguments: trucs[3],
              );
            },
          ),

          ListTile(
            title: Text(trucs[4].nom),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/second',
                arguments: trucs[4],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SecondScreen extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {

    // Récupération de l'objet envoyé par Navigator.pushNamed
    // Le cast "as Truc" indique que l'argument reçu est un Truc
    final truc = ModalRoute.of(context)!.settings.arguments as Truc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),

      body: Center(

        // Affichage des informations du Truc reçu
        child: Text(
          '${truc.id} -_- ${truc.nom}',
        ),
      ),
    );
  }
}