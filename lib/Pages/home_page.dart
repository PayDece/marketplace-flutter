import 'dart:async';

import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:integrationpaydece/Model/PaydeceResponse.dart';
import 'package:integrationpaydece/Service/PaydeceServiceBuyer.dart';
import 'package:integrationpaydece/Service/PaydeceServiceSeller.dart';

import '../theme.dart';
import '../widgets/container_response.dart';
import '../widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PaydeceResponse> responseList = [];
  String query = '';
  Timer? debouncer;
  late PaydeceResponse resto;
  bool isbuy = false;
  //late bool _isLoading;

  final controller = GroupButtonController(
    disabledIndexes: [0, 1],
    selectedIndexes: [0],
  );

  @override
  void initState() {
    //_isLoading = true;

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        //   _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future<List<PaydeceResponse>> cargarServicio(bool buy) {
    if (isbuy) {
      return PaydeceServiceBuyer.fetchPaydeceBuyOrder(query);
    } else {
      return PaydeceServiceSeller.fetchPaydeceSellOrder(query);
    }
  }

  void actualizaIsBuy(String valor, bool isactive) {
    if (valor.contains("Comprar") && isactive) {
      isbuy = isactive;
      searchResto(query);
    } else {
      isbuy = false;
      searchResto(query);
    }
  }

  Future init() async {
    final responseList;
    if (isbuy) {
      responseList = await PaydeceServiceBuyer.fetchPaydeceBuyOrder(query);
    } else {
      responseList = await PaydeceServiceSeller.fetchPaydeceSellOrder(query);
    }

    setState(() => this.responseList = responseList);
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor1,
        title: Container(
          height: 45,
        ),
      );
    }

    Widget compraventa() {
      return Container(
        margin: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GroupButton(
              isRadio: true,
              buttons: ['Comprar', 'Vender'],
              onSelected: (val, i, selected) => actualizaIsBuy(val, selected),
            )
          ],
        ),
      );
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'P2P',
              style: primaryTextStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: appBar(),
      backgroundColor: whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          compraventa(),
          buildSearch(),
          FutureBuilder(
            future: this.cargarServicio(this.isbuy),
            builder: (context, snapshort) {
              if (snapshort.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshort.hasData) {
                responseList = snapshort.data as List<PaydeceResponse>;
                return Expanded(
                  child: ListView.builder(
                    itemCount: responseList.length,
                    itemBuilder: (context, index) {
                      final resto = responseList[index];
                      return RestoTile(
                        resto: resto,
                      );
                    },
                  ),
                );
              } else if (snapshort.hasError) {
                return Center(
                  child: Text('Error: ${snapshort.error}'),
                );
              }
              return const Text(
                'show data',
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Buscar',
        onChanged: searchResto,
      );

  Future searchResto(String query) async => debounce(() async {
        final responseList;
        if (isbuy) {
          responseList = await PaydeceServiceBuyer.fetchPaydeceBuyOrder(query);
        } else {
          responseList =
              await PaydeceServiceSeller.fetchPaydeceSellOrder(query);
        }
        if (!mounted) return;

        setState(() {
          this.query = query;
          this.responseList = responseList;
        });
      });
}
