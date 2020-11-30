import 'package:flutter/material.dart';
import 'package:loja_virtual/models/address.dart';

class ExportAddressDialog extends StatelessWidget {

  const ExportAddressDialog(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
//      content: Text(
//        '${address.rua}, ${address.numero} ${address.complemento}\n'
//            '${address.bairro}\n'
//            '${address.cidade}/${address.estado}\n'
//            '${address.cep}',
//      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: <Widget>[
        FlatButton(
          onPressed: (){

          },
          child: const Text('Exportar'),
        )
      ],
    );
  }
}