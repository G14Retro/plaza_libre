import 'package:flutter/material.dart';
import 'package:plaza_libre/Components/Home/homeView.dart';
import 'package:plaza_libre/Components/MyCar/myCarView.dart';

class PlazaLibreNav extends StatefulWidget{
  const PlazaLibreNav({super.key});

  @override
  _NavigationBar createState() =>
    _NavigationBar();
  }

  class _NavigationBar extends State{
        int _selectedTab = 0;
        final List _pages = [
         Center(
          child: Text("Inicio"),
        ),
        Center(
          child: Text("Productos"), 
        ),
        Center(
          child: MyCarView(),
        ),
        Center(
          child: Text("Perfil"),
        ),
        Center(
          child: Text("Ajustes"),
        ),
      ];
      _changeTab(int index) {
        setState(() {
          _selectedTab = index;
        });
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
                icon: Icon(Icons.file_copy), label: "Perfil"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Ajustes"),
          ],
        ),
      );
    }
  }