import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/address/address_screen.dart';
import 'package:loja_virtual/screens/address/components/address_card.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffooldkey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffooldkey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __){
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true, // indica que o listview vai ocupar o menor espaço possivel
                  children: <Widget>[
                    //Nome
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (name){
                        if(name.isEmpty)
                          return 'Campo obrigatório';
                        else if (name.trim().split(' ').length <= 1)
                          return 'Preencha seu nome completo';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox( height:16),
                    //Email
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      validator: (email){
                        if(email.isEmpty)
                          return 'Campo obrigatório';
                        else if(!emailValid(email))
                          return 'E-mail Inválido';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox( height:16),
                    //Senha
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass){
                        if(pass.isEmpty)
                          return 'Campo obrigatório';
                        else if(pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox( height:16),
                    //Repita a Senha
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Repita a senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Campo obrigatório';
                        else if (pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,

                    ),
                    const SizedBox( height:16),
                    //CPF
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'CPF'),
                      enabled: !userManager.loading,
                      validator: (cpf) {
                        if (cpf.isEmpty)
                          return 'Campo obrigatório';
                        else if (cpf.length < 9)
                          return 'CPF inválido';
                        return null;
                      },
                      onSaved: (cpf) => user.cpf = cpf,
                    ),
                    const SizedBox( height:16),
                    CheckboxListTile(
                      title: Text("Fornecedor de Serviço"),
                      secondary: Icon(Icons.business_center),
                      controlAffinity:
                      ListTileControlAffinity.platform,
                      value: user.fornecedor,
                      onChanged: (bool value){
                        setState(() {
                          user.fornecedor = value;
                          print(user.fornecedor);
                        });
                      },
                      activeColor: Colors.grey,
                      checkColor: Colors.black,
                    ),
                    const SizedBox( height:16),
                    AddressCard(user),

                    SizedBox(
                      height: 44,
//                      child: RaisedButton(
//                        color: Theme.of(context).primaryColor,
//                        disabledColor:  Theme.of(context).primaryColor.withAlpha(100),
//                        textColor: Colors.white,
//                        onPressed: userManager.loading ? null : (){
//                          if(formKey.currentState.validate()){
//                            formKey.currentState.save();
//
//                            if(user.password != user.confirmPassword){
//                              scaffooldkey.currentState.showSnackBar(
//                                SnackBar(
//                                  content: const Text('Senhas não coicidem!'),
//                                  backgroundColor: Colors.red,
//                                ),
//                              );
//                              return;
//                            }
//                            //Navigator.of(context).pushNamed('/address');
//
////                            userManager.signUp(
////                                user:user,
////                                onSuccess: (){
////                                  debugPrint('Sucesso');
////                                  Navigator.of(context).pop();
////                                },
////                                onFail: (e){
////                                  scaffooldkey.currentState.showSnackBar(
////                                    SnackBar(
////                                      content: Text('Falha ao cadastrar: $e'),
////                                      backgroundColor: Colors.red,
////                                    ),
////                                  );
////                                }
////                            );
//                          }
//                        },
//
//                        child: userManager.loading ?
//                            CircularProgressIndicator(
//                              valueColor: AlwaysStoppedAnimation(Colors.white),
//                            )
//
//                        : const Text(
//                          'Criar Conta',
//                          style: TextStyle(
//                              fontSize: 18
//                          ),
//
//                        ),
//                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
