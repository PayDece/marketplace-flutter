import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integrationpaydece/Model/PaydeceResponse.dart';
import 'package:integrationpaydece/Model/PaydeceSellerRequest.dart';

class PaydeceServiceSeller {
  // API URL
  static Future<List<PaydeceResponse>> fetchPaydeceSellOrder(
      String query) async {
    //pruebo con llamar al otro service
    final response = await http.post(
      Uri.parse('https://api.paydece.io/PayDeceAPI/api/sellOrder/filter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"pageNumber": "1", "pageSize": "999"}),
    );

    PaydeceSellerRequest paydece = PaydeceSellerRequest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);

    List<Items>? listaitems = paydece.data?.items;

    List<PaydeceResponse> listarespuesta = List.empty(growable: true);
    var orderid = 0;
    var Anuncio = "";
    String? paymentMethods = "";
    var cantTransaccion = "0";
    int? totalTransaction = 0;
    Seller? seller = null;
    var precio = "0.00";
    var limite = "0.00" + "-" + "0.00";
    var disponible = "0.00";
    String? pago = "";
    String? itemHash = "";

    for (var item in listaitems!) {
      orderid = item.sellOrderId;
      seller = item.seller;
      itemHash = item.hash;
      if (seller != null) {
        Anuncio = seller.wallet;
        paymentMethods = item.paymentMethods;
        cantTransaccion = "0";
        totalTransaction = 0;
        if (seller.userScoring != null) {
          totalTransaction = seller.userScoring?.totalTransaction;
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
            isbuy: false,
            urlbasebuy: 'https://app.paydece.io/createBuy/',
            urlbasesell: 'https://app.paydece.io/create/',
            itemHash: itemHash);
        listarespuesta.add(respuesta);
      }
    }
    return listarespuesta;
  }
}
