import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Super Multilingue infini!',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Super Multilingue infini!'),
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
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(S.of(context).Titre),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 350,
                    child: Center(child: Text(S.of(context).ChatDragon)),
                  ),
                  Container(
                    width: 200,
                    height: 350,
                    child: Center(child: Text(S.of(context).ChatCone)),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 350,
                    child:
                    Center(child: Text(S.of(context).ChatBizarre)),
                  ),
                  Container(
                    width: 200,
                    height: 350,
                    child:
                    Center(child: Text(S.of(context).ChatDeGuerre)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
