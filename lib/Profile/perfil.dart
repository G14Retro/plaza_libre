import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfileScreen());
}

class User {
  final String id;
  final String name;
  final String lastName;
  final String telefon;

  User({required this.id, required this.name, required this.lastName, required this.telefon});

  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      id: id,
      name: data['name'] ?? '',
      lastName: data['lastName'] ?? '',
      telefon: data['telefon'] ?? '',
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  User? userLogin;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  bool isEditing = false;  // Variable para controlar la visibilidad del formulario

  Future<User?> getUser(String email) async {
    try {
      // Realizamos la consulta para obtener el usuario por email
      QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();

      print("Número de documentos encontrados: ${snapshot.docs.length}");

      if (snapshot.docs.isNotEmpty) {
        // Suponemos que el primer documento es el usuario que queremos
        var userData = snapshot.docs.first.data() as Map<String, dynamic>;
        String userId = snapshot.docs.first.id;  // Obtener el ID del documento
        print("Usuario encontrado: ${userData}");
        return User.fromFirestore(userData, userId);  // Pasamos el ID al crear el usuario
      } else {
        print("No se encontró ningún usuario con ese email.");
        return null;
      }
    } catch (e) {
      print("Error al obtener Usuario: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    User? fetchedUser = await getUser('Marianisoliv@gmail.com');
    setState(() {
      userLogin = fetchedUser;
      if (userLogin != null) {
        nameController.text = userLogin!.name;
        lastNameController.text = userLogin!.lastName;
        telefonController.text = userLogin!.telefon;
      }
    });
  }

  Future<void> updateUser() async {
    if (userLogin != null && userLogin!.id.isNotEmpty) {
      try {
        await userCollection.doc(userLogin!.id).update({
          'name': nameController.text,
          'lastName': lastNameController.text,
          'telefon': telefonController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Datos actualizados')));

        // Refrescar los datos del usuario después de la actualización
        setState(() {
          // Actualiza el estado con los nuevos datos del usuario
          userLogin = User(
            id: userLogin!.id,
            name: nameController.text,
            lastName: lastNameController.text,
            telefon: telefonController.text,
          );
          isEditing = false; // Cierra el formulario después de la actualización
        });

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar')));
        print("Error al actualizar: $e");
      }
    } else {
      print("ID del usuario es nulo o vacío, no se puede actualizar.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ID de usuario no válido')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      ),
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileSection(user: userLogin),
            MenuSection(user: userLogin),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isEditing) ...[
                    TextField(
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: lastNameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Apellido',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: telefonController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Número de Teléfono',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: updateUser,
                      child: Text('Actualizar'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, 
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ] else ...[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = true; // Muestra el formulario de edición
                        });
                      },
                      child: Text('Editar Perfil'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, 
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final User? user;

  ProfileSection({required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: screenWidth * 0.7,
                child: Text(
                  'Nombre',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Container(
                child: Text(
                  user?.name ?? 'Cargando...',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: screenWidth * 0.69,
                child: Text(
                  'Apellido',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Container(
                child: Text(
                  user?.lastName ?? 'Cargando...',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  final User? user;

  MenuSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          MenuItem(
            title: 'Número de teléfono',
            trailing: Text(
              user?.telefon ?? 'Cargando...',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          MenuItem(
            title: 'Correo electrónico',
            trailing: Text(
              user != null ? 'mari@gmail.com' : 'Cargando...',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          MenuItem(
            title: 'Dirección',
            trailing: Text(
              '128b # 89-85',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
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
          bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          trailing,
        ],
      ),
    );
  }
}
