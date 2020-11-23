import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/fornecedor_manager.dart';
import 'package:loja_virtual/screens/fornecedor/components/fornecedor_list_tile.dart';
import 'package:provider/provider.dart';

class FornecedorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Fornecedores'),
        centerTitle: true,
      ),
      body: Consumer<FornecedorManager>(
        builder: (_, fornecedorManager, __){
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: fornecedorManager.allFornecedores.length,
              itemBuilder: (_, index){
                return FornecedorListTile(fornecedorManager.allFornecedores[index]);
              }
          );
        },
      ),
    );
  }
}