import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plaza_libre/Components/auth/login.dart';
import 'package:plaza_libre/Components/auth/signup.dart';


// ignore: use_key_in_widget_constructors
class PlazaLibreHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomeScreen(); // Pantalla de inicio después de iniciar sesión
        } else {
          return const WelcomeScreen(); // Pantalla de bienvenida
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerrar sesión'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              // Cierra sesión con Firebase
              await FirebaseAuth.instance.signOut();
              // Redirigir a la pantalla de inicio de sesión
              Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            // tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: const Center(
        child: Text('Bienvenido a PlazaLibre'),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido sobre la imagen
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenido a PlazaLibre',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Productos frescos de campo sin salir de casa',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}