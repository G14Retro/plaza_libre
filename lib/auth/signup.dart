import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String errorMessage = '';

  // Controlador para manejar el formulario
  final _formKey = GlobalKey<FormState>();

  bool isPasswordStrong(String password) {
    // La contraseña debe tener más de 6 caracteres,
    return password.length > 5 ; // Longitud mínima de 6 caracteres
  }

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
                    // Texto de Registrarse
                    const Text(
                      'Registrarse',
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
                    const SizedBox(height: 10),
                    
                    // Campo de texto para contraseñaa
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
                        } else if (!isPasswordStrong(value)) {
                          return 'La contraseña debe tener más de 6 caracteres'; // Mensaje de error por contraseña débil
                        }
                        return null; // Si es válido, retorna null
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Botón para registrarse
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context); // Volver a la página anterior
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'email-already-in-use') {
                              setState(() {
                                errorMessage = 'Ya existe una cuenta con este correo electrónico'; // Mensaje de error
                              });
                            } else {
                              setState(() {
                                errorMessage = 'Error: ${e.message}'; // Mensaje de error genérico
                              });
                            }
                          } catch (e) {
                            setState(() {
                              errorMessage = 'Error: $e'; // Mensaje de error genérico
                            });
                          }
                        }
                      },
                      child: const Text('Registrarse'),
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
                        Navigator.pop(context); // Regresar a la página anterior
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Color del botón
                      ),
                      child: const Text('Ya tienes cuenta'),
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
