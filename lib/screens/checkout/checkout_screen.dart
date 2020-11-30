import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:loja_virtual/models/checkout_manager.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CarrinhoManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, carrinhoManager, checkoutManager) =>
        checkoutManager..updateCarrinho(carrinhoManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Confirmação de Pedido'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __){
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    const SizedBox(height: 16,),
                    Text(
                      'Processando seu Pagamento...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                      ),
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: <Widget>[
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: (){
                      checkoutManager.checkout(
                        onSuccess: (order){
                          Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/base');
                          //context.read<PageManager>().setPage(2);
                          Navigator.of(context).pushNamed(
                            '/confirmation',
                            arguments: order
                          );
                        }
                      );

                  },
                )
              ],
            );
          },
        )
      ),
    );
  }
}
