import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plaza_libre/MyCar/myCarView.dart';
import 'package:plaza_libre/Products/products.dart';
import 'package:plaza_libre/Profile/perfil.dart';
import 'package:plaza_libre/auth/login.dart';

class PlazaLibreNav extends StatefulWidget {
  const PlazaLibreNav({Key? key}) : super(key: key);

  static final ValueNotifier<int> selectedTabNotifier = ValueNotifier<int>(0); // Notificador para el índice

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<PlazaLibreNav> {
  final List<Widget> _pages = [
    const Center(child: Text("Inicio")),
    Center(child: ProductsView()),
    Center(child: MyCarView()),
    Center(child: ProfilePage()),
    const Center(child: Text("Cerrar Sesión")),
  ];

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: const Text("¿Estás seguro de que deseas cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                  await FirebaseAuth.instance.signOut();
                   // Redirigir a la pantalla de inicio de sesión
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              child: const Text("Cerrar sesión"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: PlazaLibreNav.selectedTabNotifier,
      builder: (context, selectedTab, child) {
        return Scaffold(
          appBar: AppBar(),
          body: _pages[selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedTab,
            onTap: (index) {
              if (index == 4) {
                _showLogoutConfirmation(); // Cerrar sesión en el tab de índice 4
              } else {
                PlazaLibreNav.selectedTabNotifier.value = index; // Cambiar el valor del índice
              }
            },
            selectedItemColor: const Color.fromARGB(255, 0, 184, 70),
            backgroundColor: const Color.fromARGB(255, 0, 184, 70),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
              BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Productos"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Carrito"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
              BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Cerrar Sesión"),
            ],
          ),
        );
      },
    );
  }
}
