import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/fornecedor.dart';
import 'package:loja_virtual/models/roupas_manager.dart';
import 'package:loja_virtual/screens/roupas/components/roupa_list_tile.dart';
import 'package:loja_virtual/screens/roupas/components/search_dialog.dart';
import 'package:provider/provider.dart';

class RoupasScreen extends StatelessWidget {

  RoupasScreen(this.fornecedor);

  final Fornecedor fornecedor;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<RoupasManager>(
          builder: (_, roupasManager, __){
            if(roupasManager.search.isEmpty){
                return const Text('Roupas');
            } else {
              return LayoutBuilder(
                  builder: (_, constraints){
                    return GestureDetector(
                      onTap: () async{
                        final search = await showDialog<String>(context: context,
                            builder: (_) => SearchDialog(
                              roupasManager.search
                            ));
                        if(search != null){ // sempre que o usuario voltar ou clicar fora da caixa de dialogo ele retorna null
                          roupasManager.search = search;
                        }
                      },
                      child: Container(
                          width: constraints.biggest.width,
                          child: Text(
                              roupasManager.search,
                              textAlign: TextAlign.center,
                          )
                      ) ,
                    );
                  }
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<RoupasManager>(
            builder: (_, roupasManager, __){
              if(roupasManager.search.isEmpty){
                return IconButton(
                  icon:Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(context: context,
                        builder: (_) => SearchDialog(
                            roupasManager.search
                        ));
                    if(search != null){ // sempre que o usuario voltar ou clicar fora da caixa de dialogo ele retorna null
                      roupasManager.search = search;
                    }
                  },
                );
              }else{
                return IconButton(
                  icon:Icon(Icons.close),
                  onPressed: () async {
                    roupasManager.search = '';
                  },
                );
              }
            },
          )
        ],
      ),
      body: Consumer<RoupasManager>(
        builder: (_, roupasMananger, __){
          final filteredRoupas = roupasMananger.filteredRoupas;
          return  ListView.builder(// builder vai construindo os itens conforme rola a tela para baixo
            padding: const EdgeInsets.all(4),
              itemCount: filteredRoupas.length ,
              itemBuilder: (_, index){
                return RoupasListTile(filteredRoupas[index], fornecedor);
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/carrinho');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
