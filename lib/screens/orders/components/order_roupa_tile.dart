import 'package:flutter/material.dart';
import 'package:loja_virtual/models/carrinho_roupa.dart';

class OrderRoupaTile extends StatelessWidget {

  const OrderRoupaTile(this.carrinhoRoupa);

  final CarrinhoRoupa carrinhoRoupa;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    //  onTap: (){
     //   Navigator.of(context).pushNamed(
     //       '/product', arguments: carrinhoRoupa.roupas);
      //},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(carrinhoRoupa.roupas.image),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    carrinhoRoupa.roupas.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    'R\$ ${(carrinhoRoupa.fixedPrice ?? carrinhoRoupa.unitPrice)
                        .toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            Text(
              '${carrinhoRoupa.quantidade}',
              style: const TextStyle(
                  fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}