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
      home: const MyHomePage(title: 'Acceuil'),
      routes: {
        '/myHomePage' : (context) => MyHomePage(title: 'Acceuil'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.title});
  final String title;

  @override
  State<DetailsPage> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage>{

@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),


      body: Center(
        child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  height: 200,
                  color: Colors.orange,
                  child: Center(child: Text("C'est réussi")),
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/myHomePage');
                  },
                  child: Text("Revenir à l'acceuil")
              )
            ],
          ),
      ),



  );


}
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        // Tirroir
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
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Mon super tirroir bleu\nSofiane Semid\n6240792'),
            ),
            ListTile(
              title: const Text('Détails'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(title: 'Détails'),
                    )
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
          mainAxisAlignment: .center,
          children: [
            Expanded(
              flex: 1,
            child:

                // Bloc bleu
            Container(
              height: 100,
              color: Colors.blue,
            )

            ),
            Expanded(
              flex: 2,
                child:

                    // Bloc rouge
                Container(
                  height: 100,
                  color: Colors.red,
                )

            )
          ],
        ),
          Expanded(
              flex: 1,
              child:

                  // Bloc vert
              Container(
                color: Colors.green,
              )

          ),
          Expanded(
               flex:1,
               child:
            Padding(
               padding: EdgeInsets.all(8),
               child:
                Expanded(
                   flex: 1,
                     child:
                         // Bloc jaune
                 Container(
                   color: Colors.yellow,
                 ),

                 ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child:

                    // Bloc orange
                    Container(
                      color: Colors.orange,
                    )

                ),
                Expanded(
                    flex: 2,
                    child:

                    // Bloc blanc
                    Container(
                      color: Colors.white,
                    )

                ),
                Expanded(
                    flex: 1,
                    child:

                    // Bloc Rose
                    Container(
                      color: Colors.pink,
                    )

                )
              ],
            ),
          )
        ],
      ),
      
    );
  }
}
