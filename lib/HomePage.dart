import 'package:flutter/material.dart';
import 'package:videolib/VideoUploadPage.dart';

class HomePage 
    extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('HomePage')
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 150),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoUploadPage(),));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
