
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loja_virtual/models/cepaberto_address.dart';

const token = 'abc1dc09c6daca31a4cfd3557d950579';

class CepAbertoService {

  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map>(endpoint);

      if(response.data.isEmpty){
        return Future.error('CEP Inválido');
      }
      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
      return address;
    } on DioError catch (e){
      return Future.error('Erro ao buscar CEP');
    }
  }
}