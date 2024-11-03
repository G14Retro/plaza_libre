
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Checkoutview extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String medio_pago = '';
  // ignore: use_key_in_widget_constructors
  Checkoutview(String pago){
    // ignore: unnecessary_this
    this.medio_pago = pago;
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              const Center(
                child: Text('Finalizar Pedido', style: TextStyle(fontSize: 30, color: Colors.black)),),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: screenWidth * 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.5,
                      child: const Column(
                      children: [
                        Text('Productos:'),
                        Text('Medio de pago:'),
                        Text('Total del pedido:'),
                      ],
                    ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.35,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('\$ 10.000'),
                        Text(medio_pago),
                        const Text('\$ 10.000'),
                      ],
                    ),
                    )
                  ],
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
        ],
      ),
    );
  }
  
}