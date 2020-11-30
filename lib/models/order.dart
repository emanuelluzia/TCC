import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:loja_virtual/models/carrinho_manager.dart';
import 'package:loja_virtual/models/carrinho_roupa.dart';
import 'package:loja_virtual/models/fornecedor.dart';
//armazena os indices no banco de dados
enum Status {rejeitado, pendente,transportando,preparando,concluido}

class Order{

  Order.fromCarrinhoManager(CarrinhoManager carrinhoManager){
    items = List.from(carrinhoManager.items);
    price= carrinhoManager.roupasPrice;
    userId = carrinhoManager.user.id;
    status = Status.pendente;
    fornecedorId = items[0].fornecedorID;
    //address = carrinhoManager.add


  }

  Order.fromDocument(DocumentSnapshot doc){
    orderId = doc.documentID;
    items = (doc.data['items'] as List<dynamic>).map((e){
      return CarrinhoRoupa.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    fornecedorId = doc.data['fornecedor_id'] as String;
    date = doc.data['date'] as Timestamp;
    status = Status.values[doc.data['status'] as int];
    firestore.document('users/$fornecedorId').get().then(
            (doc) {
          fornecedor = Fornecedor.fromDocument(doc);
        }
    );
    //address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    status = Status.values[doc.data['status'] as int];

  }

  final Firestore firestore = Firestore.instance;

  Future<void> save(){
    firestore.collection('orders').document(orderId).setData(
      {
        'items': items.map((e) => e.toOrderItemMap()).toList(),
        'price' : price,
        'user' : userId,
        //'address': address.toMap(),
        'fornecedor_id' : fornecedorId,
        'status': status.index,
        'date' : Timestamp.now(),
      }
    );
  }

  String orderId;

  List<CarrinhoRoupa> items;
  num price;

  String userId;

  String fornecedorId;

  Timestamp date;

  Status status;

  Fornecedor fornecedor;

  Address address;

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  String get statusText => getStatusText(status);

  Function() get back {
    return status.index >= Status.transportando.index ?
        (){
      status = Status.values[status.index - 1];
      firestore.collection('orders').document(orderId).updateData(
          {'status': status.index}
      );
    } : null;
  }

  Function() get advance {
    return status.index <= Status.preparando.index ?
        (){
      status = Status.values[status.index + 1];
      firestore.collection('orders').document(orderId).updateData(
          {'status': status.index}
      );
    } : null;
  }

  static String getStatusText(Status status) {
    switch(status){
      case Status.rejeitado:
        return 'Rejeitado';
      case Status.pendente:
        return 'Pendente';
      case Status.transportando:
        return 'Em Transporte';
      case Status.preparando:
        return 'Em preparação';
      case Status.concluido:
        return 'Concluido';
      default:
        return '';
    }
  }

  DocumentReference get firestoreRef =>
      firestore.collection('orders').document(orderId);

  void updateFromDocument(DocumentSnapshot doc){
    status = Status.values[doc.data['status'] as int];
  }

  void rejeitado(){
    status = Status.rejeitado;
    firestoreRef.updateData({'status': status.index});
  }

  @override
  String toString() {
    return 'Order{firestore: $firestore, orderId: $orderId, items: $items, price: $price, userId: $userId, fornecedorId: $fornecedorId, date: $date}';
  }
}