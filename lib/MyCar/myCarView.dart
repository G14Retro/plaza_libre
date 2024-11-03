// ignore: file_names
import 'package:flutter/material.dart';
import 'package:plaza_libre/Chekout/CheckoutView.dart';
import 'package:plaza_libre/core/providers/productProvider.dart';

// ignore: use_key_in_widget_constructors
class MyCarView extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyCarViewState createState() => _MyCarViewState();
}

class _MyCarViewState extends State<MyCarView> {
  final List<Product> products = [
    Product('Tomate', 'Verduras Siempre Frescas', 5000, 'https://placehold.co/100x100.png?text=Tomate'),
    Product('Lechuga', 'Verduras Siempre Frescas', 3000, 'https://placehold.co/100x100.png?text=Lechuga'),
    Product('Zanahoria', 'Verduras Siempre Frescas', 2000, 'https://placehold.co/100x100.png?text=Zanahoria'),
    Product('Pepino', 'Verduras Siempre Frescas', 2500, 'https://placehold.co/100x100.png?text=Pepino'),
    Product('Pimiento', 'Verduras Siempre Frescas', 4000, 'https://placehold.co/100x100.png?text=Pimiento'),
    Product('Cebolla', 'Verduras Siempre Frescas', 1500, 'https://placehold.co/100x100.png?text=Cebolla'),
    Product('Ajo', 'Verduras Siempre Frescas', 1000, 'https://placehold.co/100x100.png?text=Ajo'),
    Product('Papa', 'Verduras Siempre Frescas', 3500, 'https://placehold.co/100x100.png?text=Papa'),
    Product('Calabacín', 'Verduras Siempre Frescas', 4500, 'https://placehold.co/100x100.png?text=Calabacín'),
    Product('Berenjena', 'Verduras Siempre Frescas', 5000, 'https://placehold.co/100x100.png?text=Berenjena'),
    Product('Brócoli', 'Verduras Siempre Frescas', 5500, 'https://placehold.co/100x100.png?text=Brócoli'),
    Product('Coliflor', 'Verduras Siempre Frescas', 6000, 'https://placehold.co/100x100.png?text=Coliflor'),
    Product('Espinaca', 'Verduras Siempre Frescas', 3500, 'https://placehold.co/100x100.png?text=Espinaca'),
    Product('Apio', 'Verduras Siempre Frescas', 2500, 'https://placehold.co/100x100.png?text=Apio'),
    Product('Rábano', 'Verduras Siempre Frescas', 2000, 'https://placehold.co/100x100.png?text=Rábano'),
  ];

  @override
  Widget build(BuildContext context) {
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
