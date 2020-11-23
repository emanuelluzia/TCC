import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Roupas extends ChangeNotifier{

  Roupas.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document['name'] as String;
    description =  document['description'] as String;
    image =  document['image'] as String;
    price =  document['price'] as num;

  }

  String id;
  String name;
  String description;
  String image;
  num price;


}