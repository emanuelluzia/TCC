import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {

  CepInputField(this.address, this.user);

  final Address address;
  final User user;


  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {

  final TextEditingController cepController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    final primaryColor = Theme.of(context).primaryColor;


    if(widget.address.cep == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            enabled: !userManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'CEP',
                hintText: '12.345-678'
            ),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            keyboardType: TextInputType.number,
            validator: (cep){
              if(cep.isEmpty)
                return 'Campo obrigatório';
              else if(cep.length !=10)
                return 'CEP Inválido';
              return null;
            },
          ),
          if(userManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
              backgroundColor: Colors.transparent,
            ),
          RaisedButton(
            onPressed: !userManager.loading ? () async {
              if(Form.of(context).validate()){
                try{
                  await context.read<UserManager>().getAddress(cepController.text);
                } catch (e){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                      backgroundColor: Colors.red,
                    )
                  );

                }
              }
            } : null,
            textColor: Colors.white,
            color: primaryColor,
            disabledColor: primaryColor.withAlpha(100),
            child: const Text('Buscar CEP'),
          ),
        ],
      );
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'CEP: ${widget.address.cep}',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              CustomIconButton(
                iconData: Icons.edit,
                color: primaryColor,
                size: 20,
                onTap: (){
                  context.read<UserManager>().removeAddress();
                },
              ),
            ]
        ),
      );
  }
}