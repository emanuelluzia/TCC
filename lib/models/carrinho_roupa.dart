import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/roupas.dart';

class CarrinhoRoupa extends ChangeNotifier{

  CarrinhoRoupa.fromRoupa(this.roupas, this.fornecedor){
    roupaId = roupas.id;
    fornecedorID = fornecedor.id;
    quantidade = 1;

  }

  CarrinhoRoupa.fromDocument(DocumentSnapshot document){

    id = document.documentID;
    roupaId = document.data['roupa_id'] as String;
    quantidade = document.data['quantidade'] as int;
    fornecedorID = document.data['fornecedorID'] as String;

    firestore.document('roupas/$roupaId').get().then(
        (doc) {
          roupas = Roupas.fromDocument(doc);
          notifyListeners();
        }
    );
    firestore.document('users/$fornecedorID').get().then(
            (doc) {
          fornecedor = Fornecedor.fromDocument(doc);
        }
    );

  }

  CarrinhoRoupa.fromMap(Map<String,dynamic> map){
    roupaId = map['roupa_id'] as String;
    fornecedorID = map['fornecedorID'] as String;
    quantidade = map['quantidade'] as int;
    fixedPrice = map['fixedPrice'] as num;
    firestore.document('roupas/$roupaId').get().then(
            (doc) {
          roupas = Roupas.fromDocument(doc);
        }
    );

  }

  final Firestore firestore = Firestore.instance;

  String id;
  String roupaId;
  String fornecedorID ;
  int quantidade;
  Roupas roupas;
  Fornecedor fornecedor;

  num fixedPrice;

  num get unitPrice {
    if(roupas == null) return 0;
    return roupas.price + (roupas.price * fornecedor?.taxa ) ;
  }


  num get totalPrice => unitPrice * quantidade;


  Map<String, dynamic> toCarrinhoItemMap(){
    return {

      'roupa_id': roupaId,
      'fornecedorID' : fornecedorID,
      'quantidade' : quantidade,
    };
  }

  Map<String, dynamic> toOrderItemMap(){
    return {
      'fornecedorID': fornecedorID,
      'roupa_id': roupaId,
      'quantidade' : quantidade,
      'fixedPrice' : fixedPrice ??  unitPrice,
    };
  }

  bool stackable(Roupas roupas){
    return roupas.id == roupaId;
  }

  void increment(){
    quantidade++;
    notifyListeners();
  }

  void decrement(){
    quantidade--;
    notifyListeners();
  }
}