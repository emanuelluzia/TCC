import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';
class CancelOrderDialog extends StatelessWidget {

  const CancelOrderDialog(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rejeitar Pedido ${order.formattedId}?'),
      content: const Text('Esta ação não poderá ser defeita!'),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            order.rejeitado();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text('Rejeitar Pedido'),
        ),
      ],
    );
  }
}