import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/carrinho_roupa.dart';
import 'package:provider/provider.dart';

class CarrinhoTile extends StatelessWidget {

  const CarrinhoTile(this.carrinhoRoupa);

  final CarrinhoRoupa carrinhoRoupa;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: carrinhoRoupa,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(carrinhoRoupa.roupas.image),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Valor Original:       Valor + Taxa:',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Text(
                          'R\$ ${carrinhoRoupa.roupas.price.toStringAsFixed(2)}           R\$ ${carrinhoRoupa.unitPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Consumer<CarrinhoRoupa>(
                  builder: (_, carrinhoRoupa, __){
                    return Column(
                      children: <Widget>[
                        CustomIconButton(
                          iconData: Icons.add,
                          color: Theme.of(context).primaryColor,
                          onTap: carrinhoRoupa.increment,
                        ),
                        Text(
                          '${carrinhoRoupa.quantidade}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        CustomIconButton(
                          iconData: Icons.remove,
                          color: carrinhoRoupa.quantidade > 1 ? Theme.of(context).primaryColor : Colors.red,
                          onTap: carrinhoRoupa.decrement,
                        ),
                      ],
                    );
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
