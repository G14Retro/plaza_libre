import 'package:flutter/material.dart';
import 'package:plaza_libre/shared/navBar.dart';
import 'package:provider/provider.dart';
import 'package:plaza_libre/core/providers/productProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: ProductsView(),
    ),
  );
}

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  PlazaLibreNav.selectedTabNotifier.value = 2;
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${provider.products.length}', // Muestra la cantidad de productos en el carrito
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
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
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(product.description),
                  Text(
                    '\$ ${product.price}',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false).addProduct(product);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: TextStyle(color: Colors.white)
              ),
              child: Text('Agregar al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}