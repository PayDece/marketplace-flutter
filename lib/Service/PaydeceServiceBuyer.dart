import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integrationpaydece/Model/PaydeceResponse.dart';
import '../Model/PaydeceRequest.dart';

class PaydeceServiceBuyer {
  static Future<List<PaydeceResponse>> fetchPaydeceBuyOrder(
      String query) async {
    //pruebo con llamar al otro service
    final response = await http.post(
      Uri.parse('https://api.paydece.io/PayDeceAPI/api/buyOrder/filter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"pageNumber": "1", "pageSize": "999"}),
    );

    PaydeceRequest paydece = PaydeceRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);

    List<Items>? listaitems = paydece.data?.items;

    List<PaydeceResponse> listarespuesta = List.empty(growable: true);
    var orderid = 0;
    var Anuncio = "";
    String? paymentMethods = "";
    var cantTransaccion = "0";
    int? totalTransaction = 0;
    Buyer? buyer = null;
    var precio = "0.00";
    var limite = "0.00" + "-" + "0.00";
    var disponible = "0.00";
    String? pago = "";
    String? itemHash = "";

    for (var item in listaitems!) {
      orderid = item.buyOrderId;
      buyer = item.buyer;
      itemHash = item.hash;
      if (buyer != null) {
        Anuncio = buyer.wallet;
        paymentMethods = item.paymentMethods;
        cantTransaccion = "0";
        totalTransaction = 0;
        if (buyer.userScoring != null) {
          totalTransaction = buyer.userScoring?.totalTransaction;
          cantTransaccion = totalTransaction!.toString();
        }

        precio = item.fiatCoin!.symbol! + " " + item.amount.toString();
        limite = item.fiatCoin!.symbol! +
            " " +
            item.fromAmountRange.toString() +
            "-" +
            item.fiatCoin!.symbol! +
            " " +
            item.toAmountRange.toString();
        disponible = item.crypto!.symbol! + " " + item.amount.toString();
        pago = "";
        if (item.crypto != null) {
          Blockchain? blockchain = item.crypto?.blockchain;
          if (blockchain != null) {
            pago = blockchain.description;
          }
        }
        PaydeceResponse respuesta = new PaydeceResponse(
            orderid: orderid,
            Anuncio: Anuncio,
            cantTransaccion: cantTransaccion,
            precio: precio,
            limite: limite,
            disponible: disponible,
            pago: pago,
            paymentMethods: paymentMethods,
            isbuy: true,
            urlbasebuy: 'https://app.paydece.io/createBuy/',
            urlbasesell: 'https://app.paydece.io/create/',
            itemHash: itemHash);
        listarespuesta.add(respuesta);
      }
    }
    return listarespuesta;
  }
}
