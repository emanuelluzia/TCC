import 'package:flutter/material.dart';
import 'package:loja_virtual/models/fornecedor.dart';

class FornecedorListTile extends StatelessWidget {

  FornecedorListTile(this.fornecedor);

  final Fornecedor fornecedor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/fornecedor', arguments: fornecedor);
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
              Expanded(

                child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ' ${fornecedor.name} ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Distância:',
                          style: TextStyle(
                            color:  Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        ' ${fornecedor.distancia.toStringAsFixed(2)} KM ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.teal
                        ),

                      ),

                    ]

                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Taxa:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '${fornecedor.taxa} ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Bairro:',
                        style: TextStyle(
                          color:  Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '${fornecedor.address.bairro} ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor
                      ),
                    ),

                  ],
                ),


              )
            ],
          ),
        ),

      ),
    );
  }
}