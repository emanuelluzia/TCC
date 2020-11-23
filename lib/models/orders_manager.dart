import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class OrdersManager extends ChangeNotifier{

  User user;

  List<Order> orders = [];

  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;

  void updateUser(User user){
    this.user = user;
    //quando o usuario é modificado, limpa a tela dos pedidos
    orders.clear();

    _subscription?.cancel();
    if(user != null){
      _listenToOrders();
    }
  }

  void _listenToOrders(){
   _subscription = firestore.collection('orders').where('user', isEqualTo: user.id).snapshots()
        .listen((event) {
          orders.clear();
          for(final doc in event.documents){
            orders.add(Order.fromDocument(doc));
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