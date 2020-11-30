import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/fornecedor_manager.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:loja_virtual/models/roupas.dart';
import 'package:loja_virtual/models/roupas_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/address/address_screen.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:loja_virtual/screens/checkout/checkout_screen.dart';
import 'package:loja_virtual/screens/confirmation/confirmation_screen.dart';
import 'package:loja_virtual/screens/fornecedor/fornecedor_detalhe.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/carrinho/carrinho_screen.dart';
import 'package:loja_virtual/screens/roupas/detalhe/roupa_detalhe_screen.dart';
import 'package:loja_virtual/screens/roupas/roupas_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:loja_virtual/services/cepaberto_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
//  final response = await CloudFunctions.instance.getHttpsCallable(functionName: 'helloWorld').call();
//  print(response.data);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, FornecedorManager>(
          create: (_) => FornecedorManager(),
          lazy: false,
          update: (_, userManager, fornecedorManager) =>
          fornecedorManager..updateUser(userManager.user),

        ),
        ChangeNotifierProvider(
          create: (_) => RoupasManager(),
          lazy: false,
        ),
        //sempre que o UserManager for modificado vai informar ao PedidoManager que ocorreu uma mudança
        ChangeNotifierProxyProvider<UserManager,CarrinhoManager>(
          create: (_) => CarrinhoManager(),
          lazy: false,
          update: (_, userManager, pedidoManager) =>
          pedidoManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) =>
          adminOrdersManager..updateAdmin(userManager.user),
        ),
      ] ,
      child: MaterialApp(
        title: 'Loja do Emanuel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme:  const AppBarTheme(
            elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
       ),
       initialRoute: '/base',
       onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginSccreen()
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
            case '/roupaDetalhe':
              return MaterialPageRoute(
                  builder: (_) => RoupaDetalheScreen(settings.arguments as Roupas, settings.arguments as Fornecedor)
              );
            case '/carrinho':
              return MaterialPageRoute(
                  builder: (_) => CarrinhoScreen()
              );
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AdressScreen()
              );
            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
              );
            case '/fornecedor':
              return MaterialPageRoute(
                  builder: (_) => FornecedorDetalheScreen(settings.arguments as Fornecedor)
              );
            case '/roupaListagem':
              return MaterialPageRoute(
                  builder: (_) => RoupasScreen(settings.arguments as Fornecedor)
              );
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                    settings.arguments as Order
                  )
              );
            case '/base':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
                  settings: settings,
              );
          }
          return null;
       },
      ),
    );
  }
}


