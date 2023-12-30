import 'package:flutter/material.dart';
import 'package:integrationpaydece/Model/PaydeceResponse.dart';
import 'package:integrationpaydece/widgets/web_view_container.dart';
import '../theme.dart';

class RestoTile extends StatelessWidget {
  const RestoTile({Key? key, required this.resto}) : super(key: key);
  final PaydeceResponse resto;

  Color BotonColor(bool buycolor) {
    Color blueColor = const Color(0xFF1E39E7);
    Color redColor = Color.fromARGB(255, 247, 5, 5);
    if (buycolor) {
      return blueColor;
    } else {
      return redColor;
    }
  }

  String StringMov(bool buycolor) {
    String vender = "Vender";
    String comprar = "Comprar";
    if (buycolor) {
      return comprar;
    } else {
      return vender;
    }
  }

  String path(bool isbuy, PaydeceResponse resto) {
    print(resto.itemHash);
    if (isbuy) {
      var hash = resto.itemHash != null ? resto.itemHash : "";
      print("rutabuy" + resto.urlbasebuy + hash!);
      return resto.urlbasebuy +
          resto.itemHash!; //'e454d32f-5333-4fa6-8e07-2deb90104885';
    }
    print("rutasell" + resto.urlbasesell + resto.itemHash!);
    return resto.urlbasesell +
        resto.itemHash!; //'760ebd1a-f5fe-4ebf-8aaa-c56a35db74f3';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5, left: 30),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    resto.Anuncio,
                    style: anuncioTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    resto.cantTransaccion + " Transacciones",
                    style: anuncioTextStyle.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Precio: " + resto.precio,
                        style: anuncioTextStyle.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Limite: " + resto.limite,
                        style: anuncioTextStyle.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Disponible: " + resto.disponible,
                        style: anuncioTextStyle.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        resto.paymentMethods!,
                        style: anuncioTextStyle.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      MaterialButton(
                        height: 20.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebViewContainer(
                                        path: this.path(resto.isbuy, resto),
                                      )));
                        },
                        color: this.BotonColor(resto.isbuy),
                        child: Text(
                          this.StringMov(resto.isbuy),
                          style: anuncioTextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
