import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class AddressInputField extends StatelessWidget {

  const AddressInputField(this.address, this.user);

  final Address address;
  final User user;


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;

    return Consumer<UserManager>(
      builder: (_, userManager, __) {
       return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              initialValue: address.rua,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Rua/Avenida',
                hintText: 'Av. Brasil',
              ),
              validator: emptyValidator,
              onSaved: (t) => address.rua = t,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: address.numero,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Número',
                      hintText: '123',
                    ),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    validator: emptyValidator,
                    onSaved: (t) => address.numero = t,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: address.complemento,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Complemento',
                      hintText: 'Opcional',
                    ),
                    onSaved: (t) => address.complemento = t,
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: address.bairro,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Bairro',
                hintText: 'Guanabara',
              ),
              validator: emptyValidator,
              onSaved: (t) => address.bairro = t,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    enabled: false,
                    initialValue: address.cidade,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Cidade',
                      hintText: 'Campinas',
                    ),
                    validator: emptyValidator,
                    onSaved: (t) => address.cidade = t,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFormField(
                    autocorrect: false,
                    enabled: false,
                    textCapitalization: TextCapitalization.characters,
                    initialValue: address.estado,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'UF',
                      hintText: 'SP',
                      counterText: '',
                    ),
                    maxLength: 2,
                    validator: (e) {
                      if (e.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (e.length != 2) {
                        return 'Inválido';
                      }
                      return null;
                    },
                    onSaved: (t) => address.estado = t,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            RaisedButton(
              color: primaryColor,
              disabledColor: primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: () {
                userManager.signUp(
                                user: user,
                                address: address,
                                onSuccess: (){
                                  debugPrint('Sucesso');
                                  Navigator.of(context).pop();
                                },
                                onFail: (e){

                                }
                            );
              },
              child: const Text('Salvar cadastro'),
            ),
          ],
        );

      },
    );
  }
}