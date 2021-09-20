import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:images_increament/Models/ImageModel.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  int counter=0;
  List<ImageModel> images=[];
  
  fetchImage() async{
    counter++;
    var response=await http.get('https://jsonplaceholder.typicode.com/photos/$counter');
    if(response.statusCode == 200){
      print("got data");
      print(jsonDecode(response.body));

      var imageModel=ImageModel.fromJson(jsonDecode(response.body));
      print(imageModel.url);

      setState(() {
        images.add(imageModel);
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add images"),centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          fetchImage();
        },
      ),
      body: ListView.builder(itemCount: images.length,itemBuilder:(context,int index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(images[index].title),
              SizedBox(height: 20,),
              Image.network(images[index].url),
              SizedBox(height: 20,),


            ],
          ),
        );
      } ,)
    );
  }
}
