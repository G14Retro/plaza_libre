// ignore: file_names
import 'package:flutter/material.dart';
import 'package:plaza_libre/Chekout/CheckoutView.dart';
import 'package:plaza_libre/core/providers/productProvider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class MyCarView extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyCarViewState createState() => _MyCarViewState();
}

class _MyCarViewState extends State<MyCarView> {

  @override
  Widget build(BuildContext context) {
  final List<Product> products = Provider.of<ProductProvider>(context).products;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(5),
                  child: ProductCard(product: products[index]),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: screenWidth * 1,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción para ir a pago
                    _showOptionDialog(context);
                  },
                  child: const Text('Proceder al pago'),
                ),
              ),
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
          title: const Text('Selecciona un método de pago'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Pago en efectivo');
              },
              child: const Text('Pago en efectivo'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Pago con tarjeta');
              },
              child: const Text('Pago con Tarjeta'),
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

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(product.description,style: TextStyle(color: Colors.white),),
                  Text(
                    '\$ ${product.price}',
                    style: const TextStyle(color: Colors.white),
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
