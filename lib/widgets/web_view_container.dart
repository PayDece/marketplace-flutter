
import 'package:flutter/material.dart';
import 'package:integrationpaydece/Model/PaydeceResponse.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewContainer extends StatefulWidget{
 // const WebViewContainer({super.key});
    const WebViewContainer({
    Key? key,
    required this.path
  }) : super(key: key);

 final String path;
 
  @override
  State<WebViewContainer> createState() => _WebViewContainerState(path);


}


  class _WebViewContainerState extends State<WebViewContainer>  {
   String _ruta="";
  var controller;
    _WebViewContainerState(String ruta) {
    	  _ruta = ruta;
         print("desde el widget "+ ruta);
         controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
   // ..loadRequest(Uri.parse('https://app.paydece.io/createBuy/' +'760ebd1a-f5fe-4ebf-8aaa-c56a35db74f3'));
    ..loadRequest(Uri.parse(_ruta)); //Aca Rodrico no puedo instanciar la varibale _ruta q viene en el constructor

   	}
 
 /*
  final controller= WebViewController()
  ..setJavaScriptMode(JavaScriptMode.disabled)
  ..loadRequest(Uri.parse('https://app.paydece.io/createBuy'));
*/


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Integration Paydece",
          style: TextStyle(
                    color:Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,)
  
        ),
        
      ),
      body:WebViewWidget(controller:controller),

    );
  }
}

