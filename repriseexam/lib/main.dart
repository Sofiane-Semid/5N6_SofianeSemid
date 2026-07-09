import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repriseexam/zoo.dart';

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


  //Pq sa dit erreur 404 si on a pas passer le controller au textField?
   TextEditingController continent = TextEditingController();
   TextEditingController famille = TextEditingController();


  List<Zoo> zoos = [];

  Future<void> rechercherAnimaux() async{
    try{
      final response = await Dio().get('http://10.0.2.2:8080/exam/animaux/${continent.text}?famille=${famille.text}');
      zoos = (response.data as List).map((json) => Zoo.fromJson(json)).toList();
      setState(() {});

      for (var zoo in zoos) {

        print("Nom : ${zoo.nom}");
        print("Espèce : ${zoo.espece}");
        print("famille : ${zoo.famille}");
        print("Continent : ${zoo.continent}");
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Animal introuvable $e')));
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

          mainAxisAlignment: .start,
          children: [
            Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                        children: [
                          TextField(decoration: InputDecoration(
                            label: Text("Contient")
                          ),controller: continent,),
                          TextField(decoration: InputDecoration(
                              label: Text("Famille")
                          ),controller: famille,)
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: rechercherAnimaux, child: Text("Rechercher des animaux")),
                ],
              ),
            ),


            Expanded(
                child: ListView.builder(
                    itemCount: zoos.length,
                    itemBuilder: (context, index) {
                      final zOo = zoos[index];
                      return ListTile(
                        title: Text(zOo.nom),
                        subtitle: Text((zOo.espece)),
                        tileColor: Colors.amber,
                      );
                    }
                ))
          ],
        ),
      ),
    );
  }
}
