import 'package:flutter/material.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/roupas.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class RoupaDetalheScreen extends StatelessWidget {

  const RoupaDetalheScreen(this.roupa,this.fornecedor);

  final Roupas roupa;
  final Fornecedor fornecedor;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;


    return ChangeNotifierProvider.value(
      value: roupa,
      child: Scaffold(
        appBar: AppBar(
          title: Text(roupa.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(roupa.image),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
              '${(roupa.name)}                    Taxa: ${(fornecedor.taxa).toStringAsFixed(2)}  ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Valor Original:                                           Valor + Taxa:',
                    style: TextStyle(
                      color:Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  ),
                  Text(
                    'R\$ ${(roupa.price).toStringAsFixed(2)}                        R\$ ${(roupa.price + (roupa.price * fornecedor.taxa)).toStringAsFixed(2)}              ',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Text(
                    roupa.description,
                    style: const TextStyle(
                        fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20,),

                  SizedBox(
                    height: 44,
                   // counter = context.read<Pedi>(),
                    child: RaisedButton(
                      onPressed: (){
                      context.read<CarrinhoManager>().addToCart(roupa,fornecedor);
                      Navigator.of(context).pushNamed('/carrinho', arguments: fornecedor);
                      },
                      color: primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        'Adicionar ao Carrinho',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
