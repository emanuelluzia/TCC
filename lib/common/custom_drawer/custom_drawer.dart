import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack( // pra botar uma coisa em cima da outra
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 203, 236, 241),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTitle(
                  iconData: Icons.home,
                  title:'Início',
                  page: 0,
              ),
              DrawerTitle(
                  iconData: Icons.list,
                  title:'Criar Pedido',
                  page: 1,
              ),
              DrawerTitle(
                  iconData: Icons.playlist_add_check,
                  title:'Meus Pedidos',
                  page: 2,
              ),
              DrawerTitle(
                  iconData: Icons.home,
                  title:'Lojas',
                  page: 3,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __){
                  if(userManager.adminEnabled){
                    return Column(
                      children: <Widget>[
                        const Divider(),
                        DrawerTitle(
                          iconData: Icons.settings,
                          title:'Pedidos',
                          page: 4,
                        ),
                      ],
                    );
                  }else{
                    return Container();
                  }
                },
              )

            ],
          ),
        ],
      ),
    );
  }
}

