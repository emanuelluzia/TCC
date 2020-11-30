import 'package:flutter/material.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/roupas.dart';
import 'package:loja_virtual/screens/roupas/detalhe/roupa_detalhe_screen.dart';

class RoupasListTile extends StatelessWidget {

  const RoupasListTile(this.roupas,this.fornecedor);

  final Roupas roupas;
  final Fornecedor fornecedor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       // Navigator.of(context).pushNamed('/roupaDetalhe', arguments: {roupas,fornecedor} );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RoupaDetalheScreen(roupas, fornecedor)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(roupas.image),
              ),
              const SizedBox(width: 16,),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        roupas.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4),
                        child: Text(
                          'Valor',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        'R\$ ${roupas.price.toStringAsFixed(2)} Taxa: ${fornecedor.taxa} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor
                      ),)
                    ],

                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
