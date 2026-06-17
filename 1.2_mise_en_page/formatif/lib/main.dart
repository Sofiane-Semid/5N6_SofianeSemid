import 'package:flutter/material.dart';
import 'package:formatif/Details.dart';

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
      home: const MyHomePage(title: 'Acceuil'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(

              child: Text('Sofiane 6240792'),
            ),
            ListTile(
              title: const Text('Details'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Details(title: 'Détails'),
                    )
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children:[
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    color: Colors.blue,
                  )
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    color: Colors.red,
                  )
              ),
            ],
          ),
          Expanded(
              child: Container(
            color: Colors.green
              )
          ),
          Expanded(
            flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    color: Colors.yellow
                ),
              )
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.orange,
                    )
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                    )
                ),

                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.pink,
                    )
                ),
              ],
            ),
          ),
        ],
      ),


    );
  }
}
