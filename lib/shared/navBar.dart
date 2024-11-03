// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plaza_libre/MyCar/myCarView.dart';
import 'package:plaza_libre/Products/products.dart';
import 'package:plaza_libre/Profile/perfil.dart';
import 'package:plaza_libre/auth/login.dart';

class PlazaLibreNav extends StatefulWidget{
  const PlazaLibreNav({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationBar createState() =>
    _NavigationBar();
  }

  class _NavigationBar extends State{
        int _selectedTab = 0;
        final List _pages = [
         const Center(
          child: Text("Inicio"),
        ),
        Center(
          child: ProductsView(), 
        ),
        Center(
          child: MyCarView(),
        ),
        Center(
          child: ProfilePage(),
        ),
        Center(
          child: Text("Cerrar Sesión"),
        ),
      ];
      _changeTab(int index) {
        setState(() {
          if (index == 4) {
            _showLogoutConfirmation();  // Cerrar sesión en el tab de índice 4
          } else {
            _selectedTab = index;
          }
        });
      }

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
      return Scaffold(
        appBar: AppBar(),
        body: _pages[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: const Color.fromARGB(255, 0, 184, 70),
          backgroundColor: const Color.fromARGB(255, 0, 184, 70),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), 
              label: "Inicio",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: "Productos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Carrito"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Perfil"),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout), label: "Cerrar Sesión"),
          ],
        ),
      );
    }
  }