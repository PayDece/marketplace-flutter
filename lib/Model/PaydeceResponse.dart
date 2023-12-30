import 'package:integrationpaydece/Model/PaydeceRequest.dart';

class PaydeceResponse {
  //data Type
  late int orderid;
  late String Anuncio;
  late String cantTransaccion;
  late String precio;
  late String limite;
  //late String fromAmountRange;
  //late String toAmountRange;
  late String disponible;
  late String? pago;
  late String? paymentMethods;
  bool isbuy=true;
  late String urlbasebuy='https://app.paydece.io/createBuy/';
  late String urlbasesell='https://app.paydece.io/create/';
  late String? itemHash;

// constructor

// constructor
  PaydeceResponse({
    required this.orderid,
    required this.Anuncio,
    required this.cantTransaccion,
    required this.precio,
    required this.limite,
    required this.disponible,
    required this.pago,
    required this.paymentMethods,
    required this.isbuy,
    required this.urlbasebuy,
    required this.urlbasesell,
     required this.itemHash
  });

}