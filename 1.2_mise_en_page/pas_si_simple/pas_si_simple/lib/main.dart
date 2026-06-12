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
      home: const MyHomePage(title: 'Demo!'),
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
        title: const Text('Demo!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
          child : Column(
            children:  [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 200,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                    flex : 1,
                    child: Column(
                      children: [
                        Text("YO"),
                        Container(
                          width: 70,
                          height: 150,
                        )
                      ],
                    )
                ),
                Expanded(
                    flex : 1,
                    child: Container(height: 100, width: 50, color: Colors.black)
                ),
              ],
            ),
              Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: Text("Bouton du bas")),
              )

          ],
          )

      ),
    );
  }
}
