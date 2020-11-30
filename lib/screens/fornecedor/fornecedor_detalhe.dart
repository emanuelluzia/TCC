import 'package:flutter/material.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/screens/roupas/roupas_screen.dart';
import 'package:provider/provider.dart';

class FornecedorDetalheScreen extends StatelessWidget {

  const FornecedorDetalheScreen(this.fornecedor);

  final Fornecedor fornecedor;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;


    return ChangeNotifierProvider.value(
      value: fornecedor,
      child: Scaffold(
        appBar: AppBar(
          title: Text(fornecedor.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
//            AspectRatio(
//              aspectRatio: 1,
//            //  child: Image.network(roupa.image),
//            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    fornecedor.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Distancia                                                Taxa',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    ' ${fornecedor.distancia.toStringAsFixed(2)} KM                       ${fornecedor.taxa.toStringAsFixed(2)} ',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Endereço',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Text(
                    '${fornecedor.address.rua}, ${fornecedor.address.numero} - ${fornecedor.address.bairro}, ${fornecedor.address.cidade}, ${fornecedor.address.estado}, ${fornecedor.address.cep}',
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

                        //context.read<CarrinhoManager>().addToCart(roupa);
                        //Navigator.of(context).pushNamed('/carrinho');
                        //Navigator.of(context).pushNamed('/roupaListagem', arguments: fornecedor);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RoupasScreen(fornecedor)));

                        // return RoupasScreen(fornecedor);
                      },
                      color: primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        'Avançar',
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
