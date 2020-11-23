class Address {
  Address({this.rua, this.numero, this.complemento, this.bairro,
    this.cep, this.cidade, this.estado, this.lat, this.long});

  String rua;
  String numero;
  String complemento;
  String bairro;
  String cep;
  String cidade;
  String estado;

  double lat;
  double long;

  Address.fromMap(Map<String, dynamic> map) {
    rua = map['rua'] as String;
    numero = map['numero'] as String;
    complemento = map['complemento'] as String;
    bairro = map['bairro'] as String;
    cep = map['cep'] as String;
    cidade = map['cidade'] as String;
    estado = map['estado'] as String;
    lat = map['lat'] as double;
    long = map['long'] as double;
  }

  Map<String, dynamic> toMap() {
    return {
      'rua': rua,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cep': cep,
      'cidade': cidade,
      'estado': estado,
      'lat': lat,
      'long': long,
    };
  }
}