import 'package:flutter/material.dart';

class Checkoutview extends StatelessWidget {
  String medio_pago = '';
  Checkoutview(String pago){
    this.medio_pago = pago;
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            children: [
              Center(
                child: Text('Finalizar Pedido', style: TextStyle(fontSize: 30, color: Colors.black)),),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: screenWidth * 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      child: Column(
                      children: [
                        Text('Productos:'),
                        Text('Medio de pago:'),
                        Text('Total del pedido:'),
                      ],
                    ),
                    ),
                    Container(
                      width: screenWidth * 0.35,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('\$ 10.000'),
                        Text(medio_pago),
                        Text('\$ 10.000'),
                      ],
                    ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    child: 
                    ElevatedButton(
                    onPressed: () {
                      // Acción para ir a pago
                    },
                    child: Text('Pagar'),
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