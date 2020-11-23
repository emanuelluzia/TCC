import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/screens/address/address_screen.dart';
import 'package:loja_virtual/services/cepaberto_service.dart';

class UserManager extends ChangeNotifier {


  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  User user;
  Address address;

  bool _loading = false;
  bool get loading=> _loading;

  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      //mandando o usuario do firebase para o _loadCurrentUser para obter os dados desse usuario
      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp({User user, Address address, Function onFail, Function onSuccess}) async{
    loading = true;
    try{
    final AuthResult result = await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);

   // this.user = result.user;
    user.id = result.user.uid;
    user.address = address;
    this.user = user;

    await user.saveData();

    onSuccess();
    }on PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  //carregando os dados do usuario que esta logado
  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async{
    FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      final DocumentSnapshot docUser =  await firestore.collection("users").document(currentUser.uid).get();
    //transformou os dados do firebase em um objeto User, olhar linha 7 do user.dart
     user = User.fromDocument(docUser);
      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.fornecedor;

  Future<void> getAddress(String cep) async {
    loading = true;
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      if(cepAbertoAddress != null){
        address = Address(
            rua: cepAbertoAddress.logradouro,
            bairro: cepAbertoAddress.bairro,
            cep: cepAbertoAddress.cep,
            cidade: cepAbertoAddress.cidade.nome,
            estado: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude
        );

      }
      loading = false;
    } catch (e){
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  void removeAddress(){
    address = null;
    notifyListeners();
  }

}