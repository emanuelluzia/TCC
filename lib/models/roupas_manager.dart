import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/roupas.dart';

class RoupasManager extends ChangeNotifier{

  RoupasManager(){
    //buscar todos os produtos do firebase, TODOS
    _loadAllRoupas();
  }

  final Firestore firestore = Firestore.instance;

  List<Roupas> allRoupas = [];

  String _search = '';
  String get search => _search;

  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Roupas> get filteredRoupas{
    final List<Roupas> filteredRoupas= [];

    if(search.isEmpty){
      filteredRoupas.addAll(allRoupas);
    }else{
      filteredRoupas.addAll(
          allRoupas.where(
                  (p) => p.name.toLowerCase().contains(search.toLowerCase())
          )
      );
    }
    return filteredRoupas;
  }

  Future <void> _loadAllRoupas() async{
    final QuerySnapshot snapRoupas =
      await firestore.collection('roupas').getDocuments();

    allRoupas = snapRoupas.documents.map(
            (e) => Roupas.fromDocument(e)).toList();

    notifyListeners();
  }

}