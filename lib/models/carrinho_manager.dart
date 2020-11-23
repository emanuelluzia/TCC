import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/carrinho_roupa.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/roupas.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class CarrinhoManager extends ChangeNotifier{

  List<CarrinhoRoupa> items = [];

  User user;
  Fornecedor fornecedor;
  num roupasPrice = 0.0;

  void updateUser(UserManager userManager){
    user = userManager.user;
    items.clear();

    if(user != null){
      _loadCarrinhoItem();
    }

  }

  Future<void>_loadCarrinhoItem() async {
    final QuerySnapshot carrinhoSnap = await user.carrinhoReference.getDocuments();

    items = carrinhoSnap.documents.map(
            (d) => CarrinhoRoupa.fromDocument(d)..addListener(_onItemUpdated)
    ).toList();
    print(items);
  }

  void addToCart(Roupas roupas, Fornecedor fornecedor){
    try{//caso o produto seja igual vai juntar e incrementar a quantidade
      final e = items.firstWhere((p) => p.stackable(roupas));
      e.increment();
    } catch(e){
      final carrinhoRoupa = CarrinhoRoupa.fromRoupa(roupas, fornecedor);
      carrinhoRoupa.addListener(_onItemUpdated);
      items.add(carrinhoRoupa);
      user.carrinhoReference.add(carrinhoRoupa.toCarrinhoItemMap()).  // no momento em que é criado no firebase, ele espera o retorno do id
          then((doc) => carrinhoRoupa.id = doc.documentID);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removefromCarrinho(CarrinhoRoupa carrinhoRoupa){
    items.removeWhere((r) => r.id == carrinhoRoupa.id);
    user.carrinhoReference.document(carrinhoRoupa.id).delete();
    carrinhoRoupa.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void clear(){
    for(final carrinhoRoupa in items){
      user.carrinhoReference.document(carrinhoRoupa.id).delete();
    }
    items.clear();
    notifyListeners();
  }

  //sempre que o item sofre uma atualziacao no carrinho chama essa função
  void _onItemUpdated(){
    roupasPrice = 0.0;

    for(int i = 0; i<items.length; i++){
        final carrinhoRoupa = items[i];
      if(carrinhoRoupa.quantidade == 0){
        removefromCarrinho(carrinhoRoupa);
        i--;
        continue;
      }
      roupasPrice += carrinhoRoupa.totalPrice;
      _updateCarrinhoRoupa(carrinhoRoupa);
    }

    notifyListeners();
    print(roupasPrice);
  }

  void _updateCarrinhoRoupa(CarrinhoRoupa carrinhoRoupa){
    if(carrinhoRoupa.id != null)
      user.carrinhoReference.document(carrinhoRoupa.id)
          .updateData(carrinhoRoupa.toCarrinhoItemMap());
  }


}