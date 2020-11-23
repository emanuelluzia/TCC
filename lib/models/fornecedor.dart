import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/user.dart';

class Fornecedor extends ChangeNotifier{

  Fornecedor.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    cpf = document.data['cpf'];
    fornecedor = document.data['fornecedor'];
    taxa = document.data['taxa'];

    address = Address.fromMap(document.data['address'] as Map<String, dynamic>);
    //distancia = getDistancia(user.address.lat,user.address.long, address.lat, address.long);
  }

//  dynamic  getDistancia(double lat_origem, double long_origem, double lat_destino, double long_destino ) async {
//    double distancia = await Geolocator().distanceBetween (lat_origem, long_origem, lat_destino, long_destino);
//    distancia /= 1000.0;
//    return distancia;
//  }


  String id;
  String name;
  String email;
  String password;
  String cpf;
  bool fornecedor;
  String confirmPassword;
  Address address;
  double distancia;
  double taxa;

}