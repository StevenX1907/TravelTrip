import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<String> imageUrls = [];

  get http => null;
  @override
  void initState(){
    super.initState();
    fetchImages();
  }
  Future<void> fetchImages() async {
    final url = '';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        setState(() {
          imageUrls = List<String>.from(json.decode(response.body));
        });
      }else{

      }
    }catch (e){

    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images from MYSQL'),
      ),
      body: ListView.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context,index){
            return Image.network(imageUrls[index]);
          },
      )
    );
  }
}
