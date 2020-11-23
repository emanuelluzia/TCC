import 'package:flutter/material.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {

  const PriceCard({this.buttonText, this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
  final carrinhoManager = context.watch<CarrinhoManager>();
  final roupasPrice = carrinhoManager.roupasPrice;
  final fornecedorID = carrinhoManager.fornecedor.id;


    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch ,
            children: <Widget>[
            Text(
                'Resumo do Pedido',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Endereco'),
                  Text('R\$ ${roupasPrice.toStringAsFixed(2)}')
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Subtotal'),
                  Text('R\$ ${roupasPrice.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total',
                  style:  TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'R\$ ${roupasPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: onPressed,
                child: Text(buttonText),
              ),
          ],
        ),
        ),
    );
  }
}
