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

  TextEditingController dividendeControlleur = TextEditingController();
  TextEditingController diviseurControlleur = TextEditingController();

  String resultat = "";
  String message = "";

  void getHttp() async {
    try {
      var response = await Dio().get(
        'https://examen-final-a24.azurewebsites.net/Exam2024/Division/${dividendeControlleur.text}/${diviseurControlleur.text}',
      );

      print('${response.data}');
      print(response.statusCode);

      resultat = response.data['resultat'].toString();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(resultat)));

      setState(() {});

    }
    on DioException catch(e) {
      if(e.response?.statusCode == 400){

        print(e.response?.statusCode);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.response!.data.toString()))
        );
      }
      else {
        print(e.response?.statusCode);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Impossible de communiquer avec le serveur"))
        );
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
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: dividendeControlleur,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: diviseurControlleur,
              ),
            ),
            ElevatedButton(onPressed: getHttp, child: Text('bouton'))

          ],
      ),
    );
  }
}
