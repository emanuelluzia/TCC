import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:loja_virtual/models/order.dart';

class CheckoutManager extends ChangeNotifier{

    CarrinhoManager carrinhoManager;

    bool _loading = false;
    bool get loading => _loading;
    set loading(bool value){
      _loading = value;
      notifyListeners();
    }

    final Firestore firestore = Firestore.instance;

    void updateCarrinho(CarrinhoManager carrinhoManager){
      this.carrinhoManager = carrinhoManager;
    
      print(carrinhoManager.roupasPrice);
  }

  Future<void> checkout({Function onSuccess}) async{
    loading = true;
    //TODO: PROCESSAR PAGAMENTO

    final orderId = await _getOrderId();

    final order = Order.fromCarrinhoManager(carrinhoManager);
    order.orderId = orderId.toString();
   // _getOrderId().then((value) => print(value));

    await order.save();

    carrinhoManager.clear();
    onSuccess(order);
    loading = false;
  }



  Future<int> _getOrderId() async{
    final ref = firestore.document('aux/ordercounter');
    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data['current'] as int;
        await tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    }catch (e){
      debugPrint(e.toString());
      return Future.error('Falha ao gerar numero do pedido');
    }

  }

}