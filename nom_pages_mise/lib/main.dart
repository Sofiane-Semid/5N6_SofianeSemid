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

      home: const MyHomePage(title: 'Am'),
    );
  }
}

class Stram extends StatefulWidget {
  const Stram({super.key, required this.title});
  final String title;

  @override
  State<Stram> createState() => _Stram();
}

class _Stram extends State<Stram> {
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
              title: const Text('Am'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'Am'),
                    )
                );
              },
            ),
            ListTile(
              title: const Text('Stram'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Stram(title: 'Stram'),
                    )
                );
              },
            ),
            ListTile(
              title: const Text('Gram'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Gram(title: 'Gram'),
                    )
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(

        )

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.arrow_right_alt),
      ),
    );
}
}

class Gram extends StatefulWidget {
  const Gram({super.key, required this.title});
  final String title;

  @override
  State<Gram> createState() => _Gram();
}

class _Gram extends State<Gram> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.orange,
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Gram"),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Retour vers Am"),
              ),
            ],
          ),
        ),
      ),
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
              title: const Text('Am'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'Am'),
                    )
                );
              },
            ),
            ListTile(
              title: const Text('Stram'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Stram(title: 'Stram'),
                    )
                );
              },
            ),
            ListTile(
              title: const Text('Gram'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Gram(title: 'Gram'),
                    )
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex:6,
                child:
                Container(
                  color: Colors.blue,
                )
            ),
            Expanded(
                flex:1,
                child:
                Container(
                  color: Colors.green,
                )
            ),
            Center(
              child: Expanded(
                  flex:1,
                  child:
                  SizedBox(
                    child: Container(
                      color: Colors.yellow,
                      height: 222,
                      width: 222,
                    ),
                  )
              ),
            ),
            Expanded(
                flex: 3,
                child:
                Container(
                  color: Colors.red,
                )
            ),
            Expanded(
                flex: 4,
                child:
                Container(
                  color: Colors.orange,
                )
            )

          ],
        ),
      ),

    );
  }
}
