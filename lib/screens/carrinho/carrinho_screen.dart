import 'package:flutter/material.dart';
import 'package:loja_virtual/common/empty_card.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:loja_virtual/screens/carrinho/components/carrinho_tile.dart';
import 'package:provider/provider.dart';

class CarrinhoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CarrinhoManager>(
        builder: (_, carrinhoManager, __){
        if(carrinhoManager.items.isEmpty){
            return EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum produto no carrinho',
            );
        }
          return ListView(
            children: <Widget>[
            Column(
            children: carrinhoManager.items.map(
                    (carrinhoManager) =>CarrinhoTile(carrinhoManager)
            ).toList(),
            ),
              PriceCard(
                buttonText: 'Continuar',
                onPressed: (){
                  Navigator.of(context).pushNamed('/checkout');

                },

              ),
            ],
          );
        },
      ),
    );
  }
}
