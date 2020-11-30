import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/screens/orders/cancel_order_dialog.dart';
import 'package:loja_virtual/screens/orders/components/order_roupa_tile.dart';
import 'package:loja_virtual/screens/orders/exports_address_dialog.dart';

class OrderTile extends StatelessWidget {

  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${order.formattedId} ${order.fornecedor.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.rejeitado ? Colors.red : primaryColor,
                  fontSize: 14
              ),
            )
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e){
              return OrderRoupaTile(e,order);
            }).toList(),
          ),
          if(showControls && order.status != Status.rejeitado && order.status != Status.transportando || !showControls && order.status == Status.transportando  )
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
                children: <Widget>[
                  if(order.status != Status.concluido  )
                    FlatButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (_) => CancelOrderDialog(order)
                      );
                    },
                    textColor: Colors.red,
                    child:  Text(order.status == Status.pendente ?'Rejeitar': 'Cancelar' ),
                  ),
//                  FlatButton(
//                    onPressed: order.back,
//                    child: const Text('Voltar'),
//                  ),
                  FlatButton(
                   onPressed: order.advance,
                    textColor: Colors.green,
                    child: Text( order.status == Status.pendente ? 'Aceitar' : (order.status == Status.transportando ? 'Entregue':'Finalizar')),
                  ),

                  FlatButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          //builder: (_) => ExportAddressDialog(order.user.address)
                      );
                    },
                    textColor: primaryColor,
                    child: const Text('Endereço'),
                  ),

                ]
            ),

          )
        ],
      ),
    );
  }
}