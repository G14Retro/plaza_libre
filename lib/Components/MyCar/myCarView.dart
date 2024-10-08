import 'package:flutter/material.dart';
import 'package:plaza_libre/Components/Chekout/CheckoutView.dart';
import 'package:plaza_libre/Components/Home/homeView.dart';

class MyCarView extends StatefulWidget {
  @override
  _MyCarViewState createState() => _MyCarViewState();
}

class _MyCarViewState extends State<MyCarView> {
  int conteo = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', scale: 4,)
                        ],
                      ),
                      Column(
                        children: [
                          Text('Nombre Producto'),
                          Text('Resumen producto'),
                          Text('Precio Producto'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: screenWidth * 1,
                child: 
                ElevatedButton(
                onPressed: () {
                  // Acción para ir a pago
                  _showOptionDialog(context);
                },
                child: Text('Proceder al pago'),
              ),
              )
            ],
          ),
        ],
      ),
    );
  }
   void _showOptionDialog(BuildContext context) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Selecciona un metódo de pago'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Pago en efectivo');
              },
              child: Text('Pago en efectivo'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Pago con tarjeta');
              },
              child: Text('Pago con Tarjeta'),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Checkoutview(selected)),
      );
    }
  }
}

