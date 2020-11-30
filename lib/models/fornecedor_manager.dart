import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/user.dart';
import 'user_manager.dart';

class FornecedorManager extends ChangeNotifier{
  User user;

  FornecedorManager(){
   //
  }

  void updateUser(User user){
    this.user = user;
    if(user != null){
      //print(this.user.email);
      _loadAllFornecedores(this.user);
    }
    // print(user.);
  }

  List<Fornecedor> allFornecedores;

  final firestore = Firestore.instance;

  Future<void> _loadAllFornecedores(User user) async{
   final QuerySnapshot snapshotFornecedores =
   await firestore.collection('users').where('fornecedor', isEqualTo: true).getDocuments();

   allFornecedores = snapshotFornecedores.documents.map(
           (e) =>  Fornecedor.fromDocument(e)).toList();
   int i=0;
    for(DocumentSnapshot doc in snapshotFornecedores.documents)
      {
        print( doc.data['address']['lat']);
        double distancia = await Geolocator().distanceBetween (user.address.lat, user.address.long, doc.data['address']['lat'], doc.data['address']['long']);
        distancia /= 1000;
        allFornecedores[i].distancia = distancia;
        i++;
      }


//    print(allFornecedores.forEach((element) {
//      return element.email;
//    }));

  }


}