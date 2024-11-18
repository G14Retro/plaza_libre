
import 'package:flutter/material.dart';
import 'package:plaza_libre/core/providers/productProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Checkoutview extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String medio_pago = '';
  late double totalBuy;
  // ignore: use_key_in_widget_constructors
  Checkoutview(String pago, double total){
    // ignore: unnecessary_this
    this.medio_pago = pago;
    this.totalBuy = total;
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final screenHeight = MediaQuery.of(context).size.height;
    final List<Product> products = Provider.of<ProductProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Finalizar Pedido', style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: screenWidth,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: screenWidth * 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text('Productos:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        width: 200,
                        margin: EdgeInsets.only(left: 8),
                        child: Column(
                          children: [
                            ...products.map((product) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Text(product.name),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Text("\$${product.price.toStringAsFixed(2)}"),
                                    )                              ,
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),                      
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(                
                    child: Text("Medio de pago: ${medio_pago}"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: Text("Total a pagar: ${totalBuy}"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: 
                      ElevatedButton(
                      onPressed: () {
                        // Acción para ir a pago
                      },
                      child: const Text('Pagar'),
                    ),
                    )
                  ],
                ),              
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}