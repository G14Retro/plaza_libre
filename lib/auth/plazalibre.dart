import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plaza_libre/auth/login.dart';
import 'package:plaza_libre/auth/signup.dart';
import 'package:plaza_libre/shared/navBar.dart';


// ignore: use_key_in_widget_constructors

class News {
  final String id;
  final String title;
  final String description;

  News({required this.id, required this.title,required this.description});

  factory News.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return News(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

}

class PlazaLibreHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const PlazaLibreNav(); // Pantalla de inicio después de iniciar sesión
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
      body: Center(
        child: NewsListPage(),
      ),
    );
  }
}

class NewsListPage extends StatelessWidget {
    final CollectionReference newsCollection = FirebaseFirestore.instance.collection('news');
    Future<List<News>> getNews() async {
      try {
        QuerySnapshot snapshot = await newsCollection.get();
        return snapshot.docs.map((doc) => News.fromFirestore(doc)).toList();
      } catch (e) {
        print("Error al obtener productos: $e");
        return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bienvenido a PlazaLibre",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                'Noticias',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white70),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<News>>(
                future: getNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child:  CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar noticias'));
                  } else {
                    final news = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return NewCard(newItem: news[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
    );
  }
}

class NewCard extends StatelessWidget {
  final News newItem;

  const NewCard({Key? key, required this.newItem}) : super(key: key);

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newItem.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  Text(newItem.description,style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ],
        ),
      )
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