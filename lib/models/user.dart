import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loja_virtual/models/address.dart';

class User{

  User({this.email, this.password, this.name, this.cpf, this.fornecedor = false, this.id, this.address});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    cpf = document.data['cpf'];
    fornecedor = document.data['fornecedor'];
    address = Address.fromMap(document.data['address'] as Map<String, dynamic>);


  }

  String id;
  String name;
  String email;
  String password;
  String cpf;
  bool fornecedor;
  String confirmPassword;
//  String rua;
//  String numero;
//  String complemento;
//  String bairro;
//  String cep;
//  String cidade;
//  String estado;
//
//  double lat;
//  double long;

  Address address;


  CollectionReference get carrinhoReference => Firestore.instance.document('users/$id').collection('carrinho');

  CollectionReference get tokensReference => Firestore.instance.document('users/$id').collection('tokens');


  Future <void> saveData() async{
    await Firestore.instance.collection('users').document(id).setData(toMap());
  }



  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'cpf':cpf,
      'fornecedor':fornecedor,
      'address' : address
//      'rua': rua,
//      'numero': numero,
//      'complemento': complemento,
//      'bairro': bairro,
//      'cep': cep,
//      'cidade': cidade,
//      'estado': estado,
//      'lat': lat,
//      'long': long
    };
  }

//  bool setFornecedor(fornecedor ){
//    return fornecedor ?? ;
//  }


  Future<void> saveToken() async {
    final token = await FirebaseMessaging().getToken();
    print('token $token');
    await tokensReference.document(token).setData({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

}