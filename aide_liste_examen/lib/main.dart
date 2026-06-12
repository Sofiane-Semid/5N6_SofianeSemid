import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// TODO: EXAMEN - Vous devrez peut-être créer une classe de modèle pour représenter vos données.
// Par exemple, si vous récupérez des animaux, vous pourriez avoir une classe comme celle-ci :
/*
class Animal {
  final String nom;
  final String famille;
  final String continent;

  Animal({required this.nom, required this.famille, required this.continent});

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      nom: json['nom'],
      famille: json['famille'],
      continent: json['continent'],
    );
  }
}
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aide Examen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Contrôleurs pour les champs de texte
  final TextEditingController _param1Controller = TextEditingController();
  final TextEditingController _param2Controller = TextEditingController();

  // TODO: EXAMEN - Remplacez ce type `dynamic` par le type de votre modèle de données (par exemple, `List<Animal>`).
  List<dynamic> _items = [];
  bool _isLoading = false;

  // Fonction pour récupérer les données du service web
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: EXAMEN - Construisez votre URL ici en utilisant les contrôleurs.
    // Assurez-vous de gérer les cas où les champs sont vides si nécessaire.
    final param1 = _param1Controller.text;
    final param2 = _param2Controller.text;

    // Exemple d'URL. Vous devrez la remplacer par celle de l'examen.
    // L'adresse IP 10.0.2.2 est souvent utilisée pour accéder au localhost de la machine hôte depuis un émulateur Android.
    final url = 'http://10.0.2.2:8080/exam/animaux/$param1?famille=$param2';

    try {
      // TODO: EXAMEN - Faites l'appel réseau ici.
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Si le serveur retourne une réponse OK, analysez le JSON.
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          // TODO: EXAMEN - Mappez les données JSON à votre liste d'objets.
          // Si vous avez une classe `Animal`, vous feriez quelque chose comme :
          // _items = data.map((item) => Animal.fromJson(item)).toList();
          _items = data;
        });
      } else {
        // Si la requête échoue, affichez une erreur.
        // Vous pouvez gérer cela plus élégamment avec un SnackBar ou une boîte de dialogue.
        print('Échec du chargement des données');
      }
    } catch (e) {
      // Gérez les erreurs de réseau ici.
      print('Erreur de réseau: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: EXAMEN - Changez le titre de l'AppBar.
        title: const Text('Les animaux de mon zoo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO: EXAMEN - Adaptez les champs de texte selon les paramètres requis.
            TextField(
              controller: _param1Controller,
              decoration: const InputDecoration(
                labelText: 'Continent', // Exemple: 'Continent'
                hintText: 'monde',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _param2Controller,
              decoration: const InputDecoration(
                labelText: 'Famille', // Exemple: 'Famille'
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Rechercher les animaux'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        // TODO: EXAMEN - Personnalisez l'affichage de chaque élément de la liste.
                        // Vous devrez accéder aux propriétés de votre objet `item`.
                        // Par exemple: `item.nom`

                       /* return ListTile(
                          title: Text(item.name),
                          subtitle: Text((item.prive ? 'Privé' : 'Pubic')),
                        );*/

                        // TODO: EXAMEN - Adaptez la condition pour l'icône.
                        // Par exemple, si le continent est 'Océans'.
                        final bool isWater = item['continent'] == 'Océans';

                        return Card(
                          child: ListTile(
                            // TODO: EXAMEN - Choisissez l'icône en fonction des données.
                            leading: Icon(isWater ? Icons.water : Icons.landscape),
                            // TODO: EXAMEN - Affichez le nom de l'élément.
                            title: Text(item['nom'] ?? 'Nom inconnu'),
                            // TODO: EXAMEN - Affichez d'autres informations si nécessaire.
                            subtitle: Text(item['famille'] ?? 'Famille inconnue'),
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
