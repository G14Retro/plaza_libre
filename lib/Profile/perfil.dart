import 'package:flutter/material.dart';
import 'package:plaza_libre/Profile/perfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {},
        ),
        title: Text('Mi perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileSection(),
            MenuSection(),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://placehold.co/60x60'),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('Editar mi foto de perfil >'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Nombre',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            'Mariana',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Text(
            'Apellido',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            'Castiblanco',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          MenuItem(
            title: 'Número de teléfono',
            trailing: Text('3045829914 >'),
          ),
          MenuItem(
            title: 'Correo electrónico',
            trailing: Row(
              children: [
                Text('m***@gmail.com'),
                SizedBox(width: 5),
                Text(
                  'Sin verificar',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                Text(' >'),
              ],
            ),
          ),
          MenuItem(
            title: 'Cambiar mi contraseña',
            trailing: Text('>'),
          ),
          MenuItem(
            title: 'Mis redes sociales',
            trailing: Text('>'),
          ),
          MenuItem(
            title: 'Mis dispositivos',
            trailing: Text('>'),
          ),
          MenuItem(
            title: 'Eliminar mi cuenta',
            trailing: Text('>'),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Widget trailing;

  MenuItem({required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          trailing,
        ],
      ),
    );
  }
}