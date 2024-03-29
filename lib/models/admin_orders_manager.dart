
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/user.dart';

class AdminOrdersManager  extends ChangeNotifier{

  User user;

  List<Order> orders = [];

  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;

  void updateAdmin(User user){
    this.user = user;
    //quando o usuario é modificado, limpa a tela dos pedidos
    orders.clear();

    _subscription?.cancel();
    if(user != null){
      _listenToOrders();
    }
  }

  void _listenToOrders(){
    _subscription = firestore.collection('orders').where('fornecedor_id', isEqualTo: user.id).snapshots()
        .listen((event) {
     // orders.clear();
//      for(final doc in event.documents){
//        orders.add(Order.fromDocument(doc));
//      }
      for(final change in event.documentChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            orders.add(
                Order.fromDocument(change.document)
            );
            break;
          case DocumentChangeType.modified:
            final modOrder = orders.firstWhere(
                    (o) => o.orderId == change.document.documentID);
            modOrder.updateFromDocument(change.document);
            break;
          case DocumentChangeType.removed:
            debugPrint('Deu problema sério!!!');
            break;
        }
      }
      notifyListeners();
      print(orders);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}