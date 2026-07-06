
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


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
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<XFile> pickedImages = [];
  List<String> imageUrls = [];

  void getImages() async {
    ImagePicker picker = ImagePicker();

    pickedImages = await picker.pickMultiImage();

    setState(() {});
  }

  void sendImages() async {
    imageUrls.clear();

    Dio dio = Dio();

    for (XFile image in pickedImages) {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      });

      var response = await dio.post(
        "http://10.0.2.2:8080/singleFile",
        data: formData,
      );

      String id = response.data as String;

      String url = "http://10.0.2.2:8080/singleFile" + id;

      imageUrls.add(url);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Image Picker"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: sendImages,
            child: const Text("Envoyer les images"),
          ),

          Text("${pickedImages.length} image(s) sélectionnée(s)"),

          Expanded(
            child: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(imageUrls[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImages,
        child: const Icon(Icons.image),
      ),

    );
  }
}