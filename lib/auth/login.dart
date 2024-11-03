import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plaza_libre/auth/signup.dart';
import 'package:plaza_libre/shared/navBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String errorMessage = '';

  // Controlador para manejar el formulario
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.jpg'), // Ruta de la imagen
                fit: BoxFit.cover, // La imagen cubre toda la pantalla
              ),
            ),
          ),
          // Contenido del formulario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey, // Asignar la clave del formulario
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Texto de Iniciar Sesión
                    const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 140), // Espacio debajo del título

                    // Campo de texto para email
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white70, // Fondo semitransparente
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su correo electrónico'; // Mensaje de error
                        }
                        return null; // Si es válido, retorna null
                      },
                    ),
                    const SizedBox(height: 20),

                    // Campo de texto para contraseña
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white70,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña'; // Mensaje de error
                        }
                        return null; // Si es válido, retorna null
                      },
                    ),
                    const SizedBox(height: 20),

                    // Botón para iniciar sesión
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await _auth.signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(builder: (context) => const PlazaLibreNav()),
                        );
                          } on FirebaseAuthException catch (e) {
                            // Manejo de errores de autenticación
                            setState(() {
                              if (e.code == 'invalid-credential') {
                                errorMessage = 'Usuario o contraseña incorrecta';
                              } else if (e.code == 'user-not-found') {
                                errorMessage = 'No se encontró un usuario con este correo';
                              } else {
                                errorMessage = 'Error: ${e.message}'; // Mensaje de error genérico
                              }
                            });
                          } catch (e) {
                            setState(() {
                              errorMessage = 'Error: $e'; // Mensaje de error genérico
                            });
                          }
                        }
                      },
                      child: const Text('Iniciar Sesión'),
                    ),
                    const SizedBox(height: 20),

                    // Mensaje de error
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),

                    const SizedBox(height: 20),

                    // Botón para regresar
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Color del botón
                      ),
                      child: const Text('No tienes cuenta'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
